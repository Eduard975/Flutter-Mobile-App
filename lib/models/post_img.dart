import 'package:formz/formz.dart';

enum PostImgValidationError { invalid }

class PostImg extends FormzInput<List<String>, PostImgValidationError> {
  const PostImg.pure() : super.pure(const <String>[]);
  const PostImg.dirty([super.value = const []]) : super.dirty();

  @override
  PostImgValidationError? validator(List<String> value) {
    return (value.isNotEmpty) ? null : PostImgValidationError.invalid;
  }
}
