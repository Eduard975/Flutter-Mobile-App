import 'package:formz/formz.dart';

enum PostImageValidationError { invalid }

class PostImage extends FormzInput<String, PostImageValidationError> {
  const PostImage.pure() : super.pure('');
  const PostImage.dirty([super.value = '']) : super.dirty();
  @override
  PostImageValidationError? validator(String? value) {
    return true ? null : PostImageValidationError.invalid;
  }
}
