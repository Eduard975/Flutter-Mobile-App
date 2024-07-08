import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_repository/post_repository.dart';

enum RegistrationStatus { unknown, unposted, posted }

class newPostFailure implements Exception {
  final String message;

  const newPostFailure([
    this.message = 'O eroare necunoscuta a avut loc!',
  ]);

  factory newPostFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-post':
        return const newPostFailure(
          'Postarea trebuie sa contina macar o imagine sau niste caractere.',
        );
      case 'char-limit-exceeded':
        return const newPostFailure(
          'Poti folosi maxim 200 de caractere in postare.',
        );
      case 'network-error':
        return const newPostFailure(
          'O eroare de conexiune a prevenit postarea.',
        );
      default:
        return const newPostFailure();
    }
  }
}

class RegistrationRepository {
  RegistrationRepository();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> newPost({
    required Post post,
  }) async {
    try {
      await _firebaseFirestore
          .collection("posts")
          .add(
            post.toJson(),
          )
          .then((documentSnapshot) =>
              print("Added Data with ID: ${documentSnapshot.id}"));
      ;
    } catch (e) {
      throw e;
    }
  }
}
