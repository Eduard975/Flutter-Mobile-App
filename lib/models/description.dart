import 'package:formz/formz.dart';

enum DescriptionValidationError { invalid }

class Description extends FormzInput<String?, DescriptionValidationError> {
  const Description.pure() : super.pure(null);
  const Description.dirty([super.value]) : super.dirty();

  // Requires at least 1 char to a maximum of 200 chars
  // All of them must be alpha numeric or from the list below
  // !  @  #  $  &  (  )  -  ‘  .  /  +  ,  “ = { } [ ] ? / \ |
  static final _postTextRegExp = RegExp(
    r'''^[><?@+`~^%&\*\[\]\{\}.!#|\\\"$';,:;=\/\(\),\-\w\s+]{1,200}$''',
  );

  @override
  DescriptionValidationError? validator(String? value) {
    return _postTextRegExp.hasMatch(value ?? '')
        ? null
        : DescriptionValidationError.invalid;
  }
}
