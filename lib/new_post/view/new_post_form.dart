import 'dart:io';

import 'package:device_repository/device_repository.dart';
import 'package:first_app/new_post/new_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_repository/post_repository.dart';
// import 'dart:developer' as developer;

class NewPostForm extends StatelessWidget {
  final String userId;
  final String? replyTo;
  const NewPostForm({
    required this.userId,
    required this.replyTo,
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
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Ai postat cu succes, serifule!'),
              ),
            );
          if (replyTo == null) {
            Navigator.pop(context);
          } else {
            context.read<NewPostCubit>().resetState();
          }
        }
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 130,
          maxHeight: 350,
        ),
        padding: EdgeInsets.symmetric(
          vertical: DeviceRepository.deviceHeight(context) * 0.05,
          horizontal: DeviceRepository.deviceWidth(context) * 0.05,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            _TextInput(),
            const _DisplayImages(),
            const Padding(padding: EdgeInsets.all(8)),
            displayBottomRow(userId, replyTo)
          ],
        ),
      ),
    );
  }
}

Container displayBottomRow(String userId, String? replyTo) {
  return Container(
    constraints: const BoxConstraints(
      minHeight: 10,
      maxHeight: 40,
    ),
    child: Flexible(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _ImageInput(ImageSource.camera),
          _PostButton(
            userId: userId,
            replyTo: replyTo,
          ),
          const _ImageInput(ImageSource.gallery),
        ],
      ),
    ),
  );
}

class _TextInput extends StatefulWidget {
  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<_TextInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    final NewPostState state = context.read<NewPostCubit>().state;
    _controller.text = state.postText.value;
  }

  @override
  void didUpdateWidget(covariant _TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    final NewPostState state = context.read<NewPostCubit>().state;
    if (_controller.text != state.postText.value &&
        state.status == FormzSubmissionStatus.success) {
      _controller.text = state.postText.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 20,
        maxHeight: 80,
      ),
      child: Flexible(
        flex: 1,
        child: BlocListener<NewPostCubit, NewPostState>(
          listener: (context, state) {
            if (state.status == FormzSubmissionStatus.success) {
              _controller.clear();
            }
          },
          child: BlocBuilder<NewPostCubit, NewPostState>(
            buildWhen: (previous, current) =>
                previous.postText.value != current.postText.value ||
                previous.status != current.status,
            builder: (context, state) {
              return TextFormField(
                controller: _controller,
                onChanged: context.read<NewPostCubit>().textChanged,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Scrie-ti aici gandurile, rege!',
                  helperText: '',
                  errorText: state.postText.displayError != null
                      ? 'Invalid text'
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              pickImage().then((file) {
                if (file != null) {
                  context.read<NewPostCubit>().imageUploaded(file);
                }
              });
              // developer.log(
              //   '''\nState:
              //     Img:${file?.path}''',
              //   name: "Image picked",
              // );
            } else if (mySource == ImageSource.gallery) {
              pickImages().then((file) {
                if (file.isNotEmpty) {
                  context.read<NewPostCubit>().imagesUploaded(file);
                }
              });
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
    return Container(
      constraints: const BoxConstraints(
        minHeight: 30,
        maxHeight: 120,
      ),
      child: BlocBuilder<NewPostCubit, NewPostState>(
        buildWhen: (previous, current) => previous.postImg != current.postImg,
        builder: (context, state) {
          if (state.postImg.value.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10),
              itemCount: state.postImg.value.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Image.file(File(state.postImg.value[index])),
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          iconSize: 40,
                          color: const Color.fromARGB(255, 241, 101, 122),
                          onPressed: () =>
                              context.read<NewPostCubit>().removeImage(index),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                      ),
                    ]);
              },
            );
          }
          return const Text("Nici o imagine selectata");
        },
      ),
    );
  }
}

class _PostButton extends StatelessWidget {
  final String userId;
  final String? replyTo;
  const _PostButton({
    required this.userId,
    this.replyTo,
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
                              replyTo: replyTo,
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
