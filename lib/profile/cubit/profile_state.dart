import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = _ProfileState;
}
