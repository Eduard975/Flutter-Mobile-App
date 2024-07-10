import 'package:first_app/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:post_repository/post_repository.dart';
import 'new_post_state.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:developer' as developer;

class NewPostCubit extends Cubit<NewPostState> {
  NewPostCubit(this._postRepository) : super(const NewPostState());
  final PostRepository _postRepository;

  void textChanged(String value) {
    final postText = PostText.dirty(value);
    developer.log(
      '''\nState vechi:
          Text:${state.postText}
          Img:${state.postImg}'''
      '''\nState nou:
          Text:${postText}
          Validitate: ${Formz.validate([postText])}''',
      name: "Text Changed",
    );
    emit(
      state.copyWith(
        postText: postText,
        isValid: Formz.validate([postText]),
      ),
    );
  }

  void imageUploaded(XFile? value) {
    String path = (value == null) ? '' : value.path;
    var postImg = state.postImg;
    developer.log(
      '''\nState vechi:
          Text:${state.postText}
          Img:${state.postImg}'''
      '''\nState nou:
          Img:${postImg}
          Validitate: ${Formz.validate([postImg])}''',
      name: "Image Changed",
    );
    postImg.value.add(path);
    emit(
      state.copyWith(
        postImg: postImg,
        isValid: Formz.validate([postImg]),
      ),
    );
  }

  Future<void> submitNewPost(Post post, List<String> images) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      await _postRepository.newPost(post: post, images: images);
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
