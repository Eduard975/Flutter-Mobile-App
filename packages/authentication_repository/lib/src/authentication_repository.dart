import 'dart:async';

import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'O eroare necunoscuta a avut loc!',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Emailul introdus este invalid sau scris gresit.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'Ai cam luat ban.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Emailul introdus nu este asociat unui cont.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Parola introdusa este imposibil de gresita.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LogInWithGoogleFailure implements Exception {
  const LogInWithGoogleFailure([
    this.message = 'O eroare necunoscuta a avut loc!',
  ]);

  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Contul exista deja.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'Datele primite sunt corupte sau nu au ajuns suficient de rapid.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Actiune Interzisa! Contactati Suportul(nu exista lmao.)',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'Esti banat(nu judetul).',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Contul introdus nu exista.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Ireal cat de gresita e parola.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'Codul de verificare primit este invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'ID-ul primit este invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  final String message;
}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }
  // Future<void> logIn({
  //   required String username,
  //   required String password,
  // }) async {
  //   await Future.delayed(
  //     const Duration(milliseconds: 300),
  //     () => _controller.add(AuthenticationStatus.authenticated),
  //   );
  // }

  // void logOut() {
  //   _controller.add(AuthenticationStatus.unauthenticated);
  // }

  // void dispose() => _controller.close();
}
