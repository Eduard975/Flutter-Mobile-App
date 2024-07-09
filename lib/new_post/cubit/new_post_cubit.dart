import 'package:first_app/login/login.dart';
import 'package:first_app/models/post_img.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:post_repository/post_repository.dart';
import 'new_post_state.dart';
import 'package:image_picker/image_picker.dart';

class NewPostCubit extends Cubit<NewPostState> {
  NewPostCubit(this._postRepository) : super(const NewPostState());
  final PostRepository _postRepository;

  void textChanged(String value) {
    final postText = PostText.dirty(value);
    emit(
      state.copyWith(
        postText: postText,
        isValid: Formz.validate([postText]),
      ),
    );
  }

  void imageUploaded(XFile? value) {
    String path = (value == null) ? '' : value.path;
    final postImg = PostImg.dirty(path);

    emit(
      state.copyWith(
        postImg: postImg,
        isValid: Formz.validate([postImg]),
      ),
    );
  }

  Future<void> submitNewPost(Post post) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      await _postRepository.newPost(post: post);
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

  void resetState() {
    emit(const NewPostState());
  }
}
