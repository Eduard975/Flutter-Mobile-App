import 'package:first_app/models/description.dart';
import 'package:first_app/models/profile_img.dart';
import 'package:first_app/models/username.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(Username.pure()) Username username,
    @Default(ProfileImg.pure()) ProfileImg imgPath,
    @Default(Description.pure()) Description description,
    @Default('') String errorMessage,
    @Default(false) bool isValid,
  }) = _ProfileState;
}
