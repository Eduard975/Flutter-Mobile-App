import 'package:first_app/authentication/bloc/authentication_bloc.dart';
import 'package:first_app/new_post/cubit/new_post_cubit.dart';
import 'package:first_app/new_post/view/new_post_form.dart';
import 'package:first_app/new_post/view/new_post_page.dart';
import 'package:first_app/post_feed/view/post_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

class ReplyPage extends StatelessWidget {
  final String? userId;
  final String? replyTo;

  const ReplyPage({
    this.userId,
    this.replyTo,
    super.key,
  });

  Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => NewPostPage(
        userId: userId,
        replyTo: replyTo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.select(
      (AuthenticationBloc bloc) => bloc.state.user.name,
    );
    String titleText = "Comenteaza ceva maestre";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(titleText),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            BlocProvider(
              lazy: false,
              create: (context) => NewPostCubit(context.read<PostRepository>()),
              child: NewPostForm(
                userId: userId,
                replyTo: replyTo,
              ),
            ),
            Expanded(
              flex: 2,
              child: PostFeedWidget(
                userId: userId,
                replyTo: replyTo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
