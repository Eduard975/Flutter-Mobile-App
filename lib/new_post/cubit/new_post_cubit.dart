import 'package:first_app/login/login.dart';
import 'package:first_app/models/post_img.dart';
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
    List<String> imageList = List<String>.from(state.postImg.value);
    imageList.add(path);
    developer.log(
      '''\nState vechi:
          Path: ${path}
          Text:${state.postText}
          Img:${state.postImg}'''
      '''\nState nou:
          Img:${imageList}
          Validitate: ${Formz.validate([PostImg.dirty(imageList)])}''',
      name: "Image Changed",
    );
    emit(
      state.copyWith(
        postImg: PostImg.dirty(imageList),
        isValid: Formz.validate([PostImg.dirty(imageList)]),
      ),
    );
  }

  void imagesUploaded(List<XFile?> files) {
    List<String> paths = [];
    for (var file in files) {
      paths.add(file!.path);
    }

    List<String> imageList = List<String>.from(state.postImg.value);
    imageList.addAll(paths);
    developer.log(
      '''\nState vechi:
          Path: ${paths}
          Text:${state.postText}
          Img:${state.postImg}'''
      '''\nState nou:
          Img:${imageList}
          Validitate: ${Formz.validate([PostImg.dirty(imageList)])}''',
      name: "Image Changed",
    );
    emit(
      state.copyWith(
        postImg: PostImg.dirty(imageList),
        isValid: Formz.validate([PostImg.dirty(imageList)]),
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
