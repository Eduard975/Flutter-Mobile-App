import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:first_app/models/models.dart';
part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(Email.pure()) Email email,
    @Default(Username.pure()) Username username,
    @Default(Password.pure()) Password password,
    @Default(false) bool isValid,
  }) = _RegisterState;
}
