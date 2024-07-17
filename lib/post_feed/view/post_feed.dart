import 'package:flutter/material.dart';

import '../widgets/display_post.dart';

class PostFeedWidget extends StatelessWidget {
  final String userId;
  final String? replyTo;
  final Widget? topOfFeed;
  const PostFeedWidget({
    this.userId = '',
    this.replyTo,
    this.topOfFeed,
    super.key,
  });

  Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => PostFeedWidget(
              userId: userId,
              replyTo: replyTo,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DisplayPost.displayFeed(context, userId, replyTo, topOfFeed));
  }
}
