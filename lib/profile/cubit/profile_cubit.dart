import 'package:first_app/models/description.dart';
import 'package:first_app/models/profile_img.dart';
import 'package:first_app/models/username.dart';
import 'package:first_app/profile/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepository) : super(const ProfileState());
  final UserRepository _userRepository;

  void descriptionChanged(String? newDescription) {
    Description description = Description.dirty(newDescription);

    emit(state.copyWith(
      description: description,
      isValid: Formz.validate([description]),
    ));
  }

  void usernameChanged(String newUsername) {
    Username username = Username.dirty(newUsername);

    emit(state.copyWith(
      username: username,
      isValid: Formz.validate([username]),
    ));
  }

  void imageUploaded(XFile? value) {
    ProfileImg img = ProfileImg.dirty((value == null) ? null : value.path);

    emit(
      state.copyWith(
        imgPath: img,
        isValid: Formz.validate([img]),
      ),
    );
  }

  Future<void> submitUserEdits(User user) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      await _userRepository.updateUserProfile(
        user: user,
        newProfileImg: state.imgPath.value,
        newUserDescription: state.description.value,
        newUsername: state.username.value,
      );

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: '$e',
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}
