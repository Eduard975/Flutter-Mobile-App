import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:post_repository/post_repository.dart';
import 'dart:developer' as developer;

class PostRepository {
  PostRepository();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> newPost({
    required Post post,
    required List<String> images,
  }) async {
    try {
      int imgCount = 0;
      DocumentReference docRef = _firebaseFirestore
          .collection(
            'posts',
          )
          .doc();
      final storageRef = FirebaseStorage.instance.ref();

      for (var imagePath in images) {
        String imgIndx =
            (imgCount < 10) ? ('0' + imgCount.toString()) : imgCount.toString();
        final imageRef = storageRef.child(
          'PostImages/${post.posterId}/${docRef.id}/${imgIndx}',
        );
        await imageRef.putFile(File(imagePath));
        imgCount++;
      }
      post = post.copyWith(
        postId: docRef.id,
        postImage: "${imgCount}",
        likedBy: null,
      );
      await docRef.set(post.toJson());
    } catch (e) {
      developer.log('$e');
      throw '$e';
    }
  }

  Future<int> updatePostLikes({
    required Post post,
    required String userId,
  }) async {
    try {
      DocumentReference postDocRef = _firebaseFirestore
          .collection(
            'posts',
          )
          .doc(post.postId);

      CollectionReference collectionRef = _firebaseFirestore.collection(
        'likes',
      );
      DocumentReference likesDocRef;
      Likes likes = Likes.empty;

      if (post.likedBy == null) {
        likesDocRef = collectionRef.doc();
        post = post.copyWith(
          likedBy: likesDocRef.id,
        );
        await postDocRef.set(post.toJson());
        await likesDocRef.set(likes.toJson());
      } else {
        likesDocRef = collectionRef.doc(post.likedBy);
      }

      Set<String> usersThatLiked =
          Set<String>.from((await likesDocRef.get()).get('usersThatLiked'));

      if (usersThatLiked.contains(userId))
        usersThatLiked.remove(userId);
      else
        usersThatLiked.add(userId);

      likes = likes.copyWith(
        usersThatLiked: usersThatLiked.toList(),
      );

      developer.log('usersThatLiked: ' + likes.toString());

      await likesDocRef.set(likes.toJson());

      return likes.usersThatLiked!.length;
    } catch (e) {
      developer.log('usersThatLiked: ' + '$e');
      throw '$e';
    }
  }

  Stream<List<Post>> retriveStream({required String? replyTo}) {
    bool replyIsNull = (replyTo == null) ? true : false;
    return _firebaseFirestore
        .collection('posts')
        .where('replyTo', isNull: replyIsNull, isEqualTo: replyTo)
        .orderBy('postDate', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return Post.fromJson(docSnapshot.data());
      }).toList();
    });
  }

  Future<List<String>> retrivePostImages({
    required Post post,
  }) async {
    try {
      int imgTotal = int.parse(post.postImage);
      final storageRef = FirebaseStorage.instance.ref();
      List<String> imgUrlList = [];
      for (var i in Iterable.generate(imgTotal)) {
        String imgIndx = (i < 10) ? ('0' + i.toString()) : i.toString();
        final imageRef = storageRef
            .child('PostImages/${post.posterId}/${post.postId}/${imgIndx}');
        imgUrlList.add(await imageRef.getDownloadURL());
      }
      developer.log(imgUrlList.join('\n'));
      return imgUrlList;
    } catch (e) {
      developer.log('$e');
      throw '$e';
    }
  }
}
