import 'package:first_app/authentication/bloc/authentication_bloc.dart';
import 'package:first_app/new_post/cubit/new_post_cubit.dart';
import 'package:first_app/new_post/view/new_post_form.dart';
import 'package:first_app/post_feed/post_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

class ReplyPage extends StatelessWidget {
  final String? userId;
  final Post postReplyedTo;

  const ReplyPage({
    this.userId,
    required this.postReplyedTo,
    super.key,
  });

  Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => ReplyPage(
        userId: userId,
        postReplyedTo: postReplyedTo,
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
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            DisplayPost().displayPost(context, postReplyedTo, userId, null),
            Flexible(
              flex: 1,
              child: PostFeedWidget(
                userId: userId,
                replyTo: postReplyedTo.postId,
                topOfFeed: newCommentForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newCommentForm() {
    return BlocProvider(
      lazy: false,
      create: (context) => NewPostCubit(context.read<PostRepository>()),
      child: NewPostForm(
        userId: userId!,
        replyTo: postReplyedTo.postId,
      ),
    );
  }
}
