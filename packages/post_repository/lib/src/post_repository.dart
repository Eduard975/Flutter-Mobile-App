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
      DocumentReference docRef;
      docRef = _firebaseFirestore.collection('posts').doc();
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
}
