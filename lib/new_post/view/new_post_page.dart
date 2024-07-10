import 'package:first_app/authentication/bloc/authentication_bloc.dart';
import 'package:first_app/new_post/cubit/new_post_cubit.dart';
import 'package:first_app/new_post/view/new_post_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

class NewPostPage extends StatelessWidget {
  final String? userId;

  const NewPostPage({
    this.userId,
    super.key,
  });

  Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => NewPostPage(
              userId: userId,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.select(
      (AuthenticationBloc bloc) => bloc.state.user.name,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Posteaza ceva cumetre"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
            lazy: false,
            create: (context) => NewPostCubit(context.read<PostRepository>()),
            child: NewPostForm(
              userId: userId,
            )),
      ),
    );
  }
}
