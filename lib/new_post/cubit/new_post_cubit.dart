import 'package:first_app/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:post_repository/post_repository.dart';
import 'new_post_state.dart';

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

  Future<void> submitNewPost() async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      await _postRepository.newPost();
      emit(state.copyWith(status: FormzSubmissionStatus.success,));
    } on newPostFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure,));
    }
  }
  }
}
