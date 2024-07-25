import 'package:first_app/new_post/new_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
// import 'dart:developer' as developer;

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
                content: Text('N-am putut modifica datele'),
              ),
            );
        } else if (state.status == FormzSubmissionStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Te-ai editat 10/10'),
              ),
            );
        }
      },
      child: Container(),
    );
  }
}
