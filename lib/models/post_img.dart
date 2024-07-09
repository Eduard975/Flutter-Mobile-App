import 'package:formz/formz.dart';

enum PostImgValidationError { invalid }

class PostImg extends FormzInput<String, PostImgValidationError> {
  const PostImg.pure() : super.pure('');
  const PostImg.dirty([super.value = '']) : super.dirty();

  // Requires at least 1 char to a maximum of 200 chars
  // All of them must be alpha numeric or from the list below
  // !  @  #  $  &  (  )  -  ‘  .  /  +  ,  “ = { } [ ] ? / \ |

  @override
  PostImgValidationError? validator(String? value) {
    return (value == '') ? null : PostImgValidationError.invalid;
  }
}
