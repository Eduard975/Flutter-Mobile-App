class AuthenticationState extends Equatable {
  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
}

import 'package:authentication_repository/authentification_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState{
  const factory AuthenticationState({
    @Default(AuthenticationStatus.unknown) AuthenticationStatus status,
    @Default(User.empty) User user,
  }) = _AuthenticationState;
}
