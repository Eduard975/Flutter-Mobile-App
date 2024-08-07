import 'package:first_app/authentication/bloc/authentication_bloc.dart';
import 'package:first_app/new_post/new_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

class NewPostPage extends StatelessWidget {
  final String? replyTo;

  const NewPostPage({
    this.replyTo,
    super.key,
  });

  Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => NewPostPage(
        replyTo: replyTo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.select(
      (AuthenticationBloc bloc) => bloc.state.user.name,
    );
    String titleText = "Posteaza ceva cumetre";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(titleText),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          lazy: false,
          create: (context) => NewPostCubit(context.read<PostRepository>()),
          child: NewPostForm(
            userId: userId,
            replyTo: replyTo,
          ),
        ),
      ),
    );
  }
}
