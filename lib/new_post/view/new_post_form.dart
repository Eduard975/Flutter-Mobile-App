import 'dart:io';

import 'package:first_app/new_post/cubit/new_post_cubit.dart';
import 'package:first_app/new_post/cubit/new_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_repository/post_repository.dart';

class NewPostForm extends StatelessWidget {
  final String userId;
  final fieldTextController = TextEditingController();

  NewPostForm({
    required this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPostCubit(context.read<PostRepository>()),
      child: BlocListener<NewPostCubit, NewPostState>(
        listener: (context, state) {
          if (state.status == FormzSubmissionStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Failed to post'),
                ),
              );
          } else if (state.status == FormzSubmissionStatus.success) {
            fieldTextController.clear();
            context.read<NewPostCubit>().resetState();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Ai postat cu succes, serifule!'),
                ),
              );
          }
        },
        child: Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TextInput(fieldTextController: fieldTextController),
                const Expanded(
                  flex: 1,
                  child: _DisplayImages(),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _PostButton(
                      userId: userId,
                      fieldTextController: fieldTextController,
                    ),
                    const _ImageInput(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  final TextEditingController fieldTextController;
  const _TextInput({
    required this.fieldTextController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPostCubit, NewPostState>(
      buildWhen: (previous, current) => previous.postText != current.postText,
      builder: (context, state) {
        return TextField(
          key: const Key('newPostForm_textInput_textField'),
          onChanged: context.read<NewPostCubit>().textChanged,
          keyboardType: TextInputType.text,
          controller: fieldTextController,
          decoration: InputDecoration(
            labelText: 'Scrie-ti aici gandurile, rege!',
            helperText: '',
            errorText:
                state.postText.displayError != null ? 'Invalid text' : null,
          ),
        );
      },
    );
  }
}

class _ImageInput extends StatelessWidget {
  const _ImageInput();

  Future<XFile?> pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPostCubit, NewPostState>(
      buildWhen: (previous, current) => previous.postImg != current.postImg,
      builder: (context, state) {
        return IconButton(
          onPressed: () async {
            XFile? file = await pickImage();
            context.read<NewPostCubit>().imageUploaded(file);
          },
          icon: const Icon(Icons.camera_alt),
        );
      },
    );
  }
}

class _DisplayImages extends StatelessWidget {
  const _DisplayImages();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPostCubit, NewPostState>(
      buildWhen: (previous, current) => previous.postImg != current.postImg,
      builder: (context, state) {
        if (state.postImg.value.isNotEmpty) {
          return Image.file(File(state.postImg.value));
        } else {
          return const Text("Nici o imagine selectata");
        }
      },
    );
  }
}

class _PostButton extends StatelessWidget {
  final String userId;
  final TextEditingController fieldTextController;
  const _PostButton({
    required this.userId,
    required this.fieldTextController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPostCubit, NewPostState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('newPostForm_postButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600),
                ),
                onPressed: state.isValid
                    ? () {
                        context.read<NewPostCubit>().submitNewPost(Post(
                              postId: '',
                              postText: state.postText.value,
                              postImage: state.postImg.value,
                              postDate: DateTime.now().toUtc().toString(),
                              posterId: userId,
                            ));
                      }
                    : null,
                child: const Text('Posteaza'),
              );
      },
    );
  }
}
