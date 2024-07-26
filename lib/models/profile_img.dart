import 'package:formz/formz.dart';

enum ProfileImgValidationError { invalid }

class ProfileImg extends FormzInput<String?, ProfileImgValidationError> {
  const ProfileImg.pure() : super.pure(null);
  const ProfileImg.dirty([super.value]) : super.dirty();

  @override
  ProfileImgValidationError? validator(String? value) {
    return (value != null) ? null : ProfileImgValidationError.invalid;
  }
}
