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
      DocumentReference postsDocRef = _firebaseFirestore
          .collection(
            'posts',
          )
          .doc();
      DocumentReference likesDocRef = _firebaseFirestore
          .collection(
            'likes',
          )
          .doc();
      final storageRef = FirebaseStorage.instance.ref();

      await likesDocRef.set(Likes.empty.toJson());

      for (var imagePath in images) {
        String imgIndx =
            (imgCount < 10) ? ('0' + imgCount.toString()) : imgCount.toString();
        final imageRef = storageRef.child(
          'PostImages/${post.posterId}/${postsDocRef.id}/${imgIndx}',
        );
        await imageRef.putFile(File(imagePath));
        imgCount++;
      }
      post = post.copyWith(
        postId: postsDocRef.id,
        postImage: "${imgCount}",
        likedBy: likesDocRef.id,
      );

      await postsDocRef.set(post.toJson());
    } catch (e) {
      developer.log('$e');
      throw '$e';
    }
  }

  Future<(bool, int)> updatePostLikes({
    required Post post,
    required String userId,
    bool btnPress = false,
  }) async {
    try {
      DocumentReference likesDocRef = _firebaseFirestore
          .collection(
            'likes',
          )
          .doc(post.likedBy);

      Likes likes = Likes.empty;
      List<String> usersThatLiked =
          List<String>.from((await likesDocRef.get()).get(
        'usersThatLiked',
      ));
      bool isLiked = false;
      if (usersThatLiked.contains(userId)) {
        isLiked = true;
      }

      if (btnPress) {
        if (isLiked) {
          usersThatLiked.remove(userId);
        } else {
          usersThatLiked.add(userId);
        }
        isLiked = !isLiked;
      }

      likes = likes.copyWith(
        usersThatLiked: usersThatLiked,
      );

      developer.log('usersThatLiked: ' + likes.toString());

      await likesDocRef.set(likes.toJson());

      return (isLiked, likes.usersThatLiked!.length);
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
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (docSnapshot) {
            return Post.fromJson(docSnapshot.data());
          },
        ).toList();
      },
    );
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
