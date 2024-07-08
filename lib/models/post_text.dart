import 'package:formz/formz.dart';

enum PostTextValidationError { invalid }

class PostText extends FormzInput<String, PostTextValidationError> {
  const PostText.pure() : super.pure('');
  const PostText.dirty([super.value = '']) : super.dirty();

  // Requires at least 1 char to a maximum of 200 chars
  // All of them must be alpha numeric or from the list below
  // !  @  #  $  &  (  )  -  ‘  .  /  +  ,  “ = { } [ ] ? / \ |
  static final _postTextRegExp = RegExp(
    r'''^[><?@+`~^%&\*\[\]\{\}.!#|\\\"$';,:;=\/\(\),\-\w\s+]{1,200}$''',
  );

  @override
  PostTextValidationError? validator(String? value) {
    return _postTextRegExp.hasMatch(value ?? '')
        ? null
        : PostTextValidationError.invalid;
  }
}
