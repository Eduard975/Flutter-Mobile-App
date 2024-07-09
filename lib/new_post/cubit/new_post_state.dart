import 'package:first_app/models/post_img.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/models.dart';
part 'new_post_state.freezed.dart';

@freezed
class NewPostState with _$NewPostState {
  const factory NewPostState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(PostText.pure()) PostText postText,
    @Default(PostImg.pure()) PostImg postImg,
    @Default('') String errorMessage,
    @Default(false) bool isValid,
  }) = _NewPostState;
}
