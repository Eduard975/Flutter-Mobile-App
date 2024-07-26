import 'package:formz/formz.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();
  /*
  ^(?=.{6,16}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$
 └─────┬────┘└───┬──┘└─────┬─────┘└─────┬─────┘ └───┬───┘
       │         │         │            │           no _ or . at the end
       │         │         │            │
       │         │         │            allowed characters
       │         │         │
       │         │         no __ or _. or ._ or .. inside
       │         │
       │         no _ or . at the beginning
       │
       username is 6-16 characters long
  */

  static final _usernameRegExp =
      RegExp(r'^(?=.{6,16}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$');

  @override
  UsernameValidationError? validator(String? value) {
    bool respectTextFormatCondition = (_usernameRegExp.hasMatch(value ?? ''));
    bool noDuplicateUsernameCondition = true;

    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .where('name', isEqualTo: value)
    //     .get()
    //     .then((snapshot) => {
    //           if (snapshot.docs.isNotEmpty)
    //             {
    //               noDuplicateUsernameCondition = false,
    //             }
    //         });

    return (respectTextFormatCondition && noDuplicateUsernameCondition)
        ? null
        : UsernameValidationError.invalid;
  }
}
