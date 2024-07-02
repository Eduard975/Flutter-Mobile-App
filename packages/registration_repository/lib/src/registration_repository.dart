import 'dart:async';
//import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

enum RegistrationStatus { unknown, unregistered, registered }

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Emailul introdus este invalid sau scris gresit.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'Of of, tot banat.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'Exista deja un cont cu acest email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Actiune interzisa. Contacteaza suportul(nu Mercy).',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Parola cam slaba, mai adauga si tu niste caractere.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class RegistrationRepository {
  final _controller = StreamController<RegistrationStatus>();

  Stream<RegistrationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield RegistrationStatus.unregistered;
    yield* _controller.stream;
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(RegistrationStatus.registered),
    );
  }

  void dispose() => _controller.close();
}
