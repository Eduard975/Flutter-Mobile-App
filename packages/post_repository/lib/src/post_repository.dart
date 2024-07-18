import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:post_repository/post_repository.dart';
import 'dart:developer' as developer;

class PostRepository {
  PostRepository();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //TODO: Add support for storing and retrieving likes
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
          '${post.posterId}/${docRef.id}/${imgIndx}',
        );
        await imageRef.putFile(File(imagePath));
        imgCount++;
      }
      post = post.copyWith(
        postId: docRef.id,
        postImage: "${imgCount}",
      );
      await docRef.set(post.toJson());
    } catch (e) {
      developer.log('$e');
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
        final imageRef =
            storageRef.child('${post.posterId}/${post.postId}/${imgIndx}');
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
