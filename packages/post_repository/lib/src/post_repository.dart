import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:post_repository/post_repository.dart';

class PostRepository {
  PostRepository();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> newPost({
    required Post post,
  }) async {
    try {
      DocumentReference docRef;
      // if (post.postImage != '') {
      //   docRef = _firebaseFirestore.collection('post-images').doc();
      // }
      docRef = _firebaseFirestore.collection('posts').doc();
      post = post.copyWith(postId: docRef.id);
      await docRef.set(post.toJson());
    } catch (e) {
      debugPrint('$e');
      throw '$e';
    }
  }
}
