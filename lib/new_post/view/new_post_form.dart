import 'dart:io';

import 'package:first_app/new_post/cubit/new_post_cubit.dart';
import 'package:first_app/new_post/cubit/new_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_repository/post_repository.dart';
import 'dart:developer' as developer;

class NewPostForm extends StatelessWidget {
  final String userId;

  const NewPostForm({
    required this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewPostCubit, NewPostState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Nu s-a postat, sefule'),
              ),
            );
        } else if (state.status == FormzSubmissionStatus.success) {
          context.read<NewPostCubit>().resetState();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Ai postat cu succes, serifule!'),
              ),
            );
          Navigator.pop(context);
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
              _TextInput(),
              const Expanded(
                flex: 1,
                child: _DisplayImages(),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _ImageInput(ImageSource.camera),
                  _PostButton(
                    userId: userId,
                  ),
                  const _ImageInput(ImageSource.gallery),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPostCubit, NewPostState>(
      buildWhen: (previous, current) => previous.postText != current.postText,
      builder: (context, state) {
        return TextFormField(
          key: const Key('newPostForm_textInput_textField'),
          onChanged: context.read<NewPostCubit>().textChanged,
          keyboardType: TextInputType.text,
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
  final ImageSource mySource;
  const _ImageInput(
    this.mySource,
  );

  Future<XFile?> pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }

  Future<List<XFile>> pickImages() async {
    return await ImagePicker().pickMultiImage(limit: 10);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPostCubit, NewPostState>(
      buildWhen: (previous, current) => previous.postImg != current.postImg,
      builder: (context, state) {
        return IconButton(
          onPressed: () async {
            if (mySource == ImageSource.camera) {
              XFile? file = await pickImage();
              context.read<NewPostCubit>().imageUploaded(file);

              // developer.log(
              //   '''\nState:
              //     Img:${file?.path}''',
              //   name: "Image picked",
              // );
            } else if (mySource == ImageSource.gallery) {
              List<XFile> file = await pickImages();
              context.read<NewPostCubit>().imagesUploaded(file);

              // developer.log(
              //   '''\nState:
              //     Img:${file}''',
              //   name: "Images picked",
              // );
            }
          },
          icon: (mySource == ImageSource.camera)
              ? const Icon(Icons.camera_alt)
              : const Icon(Icons.add_a_photo_outlined),
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
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: state.postImg.value.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => {context.read<NewPostCubit>().removeImage(index)},
                child: Image.file(
                  File(state.postImg.value[index]),
                ),
              );
            },
          );
        }
        return const Text("Nici o imagine selectata");
      },
    );
  }
}

class _PostButton extends StatelessWidget {
  final String userId;
  const _PostButton({
    required this.userId,
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
                        context.read<NewPostCubit>().submitNewPost(
                            Post(
                              postId: '',
                              postText: state.postText.value,
                              postImage: state.postImg.value.length.toString(),
                              postDate: DateTime.now().toUtc().toString(),
                              posterId: userId,
                            ),
                            state.postImg.value);
                      }
                    : null,
                child: const Text('Posteaza'),
              );
      },
    );
  }
}
