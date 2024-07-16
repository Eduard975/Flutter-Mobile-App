import 'package:first_app/reply/view/reply_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:date_format/date_format.dart';
import '../widgets/image_carousel.dart';

class PostFeedWidget extends StatelessWidget {
  final String userId;
  final String? replyTo;
  const PostFeedWidget({
    this.userId = '',
    this.replyTo,
    super.key,
  });

  Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => PostFeedWidget(
              userId: userId,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Post>>(
        stream: context.read<PostRepository>().retriveStream(replyTo: replyTo),
        builder: (context, postsSnapshot) {
          // Handle different connection states
          if (postsSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (postsSnapshot.connectionState == ConnectionState.active ||
              postsSnapshot.connectionState == ConnectionState.done) {
            if (postsSnapshot.hasData && postsSnapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: postsSnapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = postsSnapshot.data![index];
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    constraints: const BoxConstraints(
                      minHeight: 10,
                      maxHeight: 400,
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisSize: MainAxisSize.min,
                      verticalDirection: VerticalDirection.down,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        displayPosterId(post.posterId),
                        displayPostText(post.postText),
                        const Flexible(flex: 1, child: SizedBox(height: 10)),
                        ImageCarousel(
                          futureUrls: context
                              .read<PostRepository>()
                              .retrivePostImages(post: post),
                        ),
                        const Flexible(flex: 2, child: SizedBox(height: 20)),
                        displayBottmRow(context, post.postId, post.postDate),
                      ],
                    ),
                  );
                },
              );
            } else if (postsSnapshot.hasError) {
              return Center(
                child: Text('Problem loading posts: ${postsSnapshot.error}'),
              );
            } else {
              return const Center(
                child: Text('No posts available'),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  String parseDate(String date) {
    DateTime myDate = DateTime.parse(date).toLocal();
    return formatDate(myDate, [HH, ':', nn, ' ', d, '-', MM, '-', yyyy]);
  }

  Widget displayBottmRow(BuildContext context, String postId, String postDate) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        displayDate(postDate),
        displayReplyBtn(context, postId),
      ],
    );
  }

  Widget displayReplyBtn(BuildContext context, String postId) {
    return IntrinsicHeight(
      child: IconButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReplyPage(
                userId: userId,
                replyTo: postId,
              ),
            )),
        icon: const Icon(Icons.comment_rounded),
        iconSize: 25,
      ),
    );
  }

  Widget displayDate(String postDate) {
    return Text(
      parseDate(postDate),
      style: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
    );
  }

  Widget displayPostText(String postText) {
    return Text(
      postText,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic,
        color: Colors.black87,
      ),
    );
  }

  Widget displayPosterId(String posterId) {
    return Row(
      children: [
        Text(
          posterId,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            (replyTo == null) ? ' a postat:' : ' a comentat:',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
