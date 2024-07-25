import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_repository/user_repository.dart';

enum RegistrationStatus { unknown, unregistered, registered }

class RegisterWithEmailAndPasswordFailure implements Exception {
  final String message;
  const RegisterWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory RegisterWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const RegisterWithEmailAndPasswordFailure(
          'Emailul introdus este invalid sau scris gresit.',
        );
      case 'email-already-in-use':
        return const RegisterWithEmailAndPasswordFailure(
          'Exista deja un cont cu acest email.',
        );
      case 'operation-not-allowed':
        return const RegisterWithEmailAndPasswordFailure(
          'Actiune interzisa. Contacteaza suportul(nu Mercy).',
        );
      case 'weak-password':
        return const RegisterWithEmailAndPasswordFailure(
          'Parola cam slaba, mai adauga si tu niste caractere.',
        );
      default:
        return const RegisterWithEmailAndPasswordFailure();
    }
  }
}

class RegistrationRepository {
  RegistrationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  Future<void> register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      firebase_auth.UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      firebase_auth.User? user = userCredential.user;
      if (user != null) {
        String? userId = await user.uid;

        await FirebaseFirestore.instance
            .collection(
              'users',
            )
            .doc(userId)
            .set(
              User(
                id: userId,
                email: email,
                name: name,
              ).toJson(),
            );

        //.set(myUser.toJson());

        await user.reload();
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw RegisterWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw e;
    }
  }
}
