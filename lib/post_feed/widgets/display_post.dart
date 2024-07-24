import 'package:date_format/date_format.dart';
import 'package:first_app/post_feed/widgets/image_carousel.dart';
import 'package:first_app/post_feed/widgets/like_widget.dart';
import 'package:first_app/reply/view/reply_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

class DisplayPost {
  DisplayPost();
  String parseDate(String date) {
    DateTime myDate = DateTime.parse(date).toLocal();
    return formatDate(myDate, [HH, ':', nn, ' ', d, '-', MM, '-', yyyy]);
  }

  Widget displayFeed(BuildContext context, String userId,
      [String? replyTo, Widget? topOfList]) {
    bool isInReplyThread = (topOfList != null);
    return StreamBuilder<List<Post>>(
      stream: context.read<PostRepository>().retriveStream(replyTo: replyTo),
      builder: (context, postsSnapshot) {
        if (postsSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (postsSnapshot.connectionState == ConnectionState.active ||
            postsSnapshot.connectionState == ConnectionState.done) {
          if (postsSnapshot.hasData && postsSnapshot.data!.isNotEmpty) {
            var itemCount = isInReplyThread
                ? postsSnapshot.data!.length + 1
                : postsSnapshot.data!.length;

            return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final Post post;
                if (topOfList == null) {
                  post = postsSnapshot.data![index];
                } else {
                  if (index == 0) {
                    return topOfList;
                  } else {
                    post = postsSnapshot.data![index - 1];
                  }
                }
                return DisplayPost().displayPost(
                  context,
                  post,
                  userId,
                  isInReplyThread,
                  replyTo,
                );
              },
            );
          } else if (postsSnapshot.hasError) {
            return Center(
              child: Text('Problem loading posts: ${postsSnapshot.error}'),
            );
          } else {
            return ListView(
              children: <Widget>[
                (topOfList == null) ? Container() : topOfList,
                const SizedBox(height: 10),
                Center(
                  child: Text((replyTo == null)
                      ? 'N-avem postari man'
                      : 'Fii primul care comenteza!'),
                ),
              ],
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget displayPost(
      BuildContext context, Post post, String userId, bool isInReplyThread,
      [String? replyTo]) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      constraints: const BoxConstraints(
        minHeight: 10,
        maxHeight: 250,
      ),
      child: Flex(
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          displayTopRow(context, post, userId, replyTo, isInReplyThread),
          displayPostText(post.postText),
          ImageCarousel(
            futureUrls:
                context.read<PostRepository>().retrivePostImages(post: post),
          ),
          displayBottomRow(context, post, userId),
        ],
      ),
    );
  }

  Widget displayBottomRow(BuildContext context, Post post, String userId) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        displaylikeBtn(context, post, userId),
        displayDate(post.postDate),
        displayReplyBtn(context, post, userId),
      ],
    );
  }

  Widget displaylikeBtn(BuildContext context, Post post, String userId) {
    return LikeWidget(
      post: post,
      userId: userId,
    );
  }

  Widget displayReplyBtn(BuildContext context, Post post, String userId) {
    return Flexible(
      flex: 1,
      child: IconButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ReplyPage(
              userId: userId,
              postReplyedTo: post,
            );
          },
        )),
        icon: const Icon(Icons.comment_rounded),
        iconSize: 30,
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

  Widget displayTopRow(
    BuildContext context,
    Post post,
    String userId,
    String? replyTo,
    bool isInReplyThread,
  ) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            post.posterId + ((replyTo == null) ? ' a postat:' : ' a comentat:'),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          displayDeleteButton(context, post, userId, isInReplyThread)
        ],
      ),
    );
  }

  Widget displayDeleteButton(
    BuildContext context,
    Post post,
    String userId,
    bool isInReplyThread,
  ) {
    return (post.posterId == userId)
        ? IconButton(
            onPressed: () => {
              context.read<PostRepository>().deletePost(
                    postId: post.postId,
                    posterId: post.posterId,
                    likedBy: post.likedBy!,
                    userId: userId,
                  ),
              if (post.replyTo == null || isInReplyThread)
                {Navigator.pop(context)}
            },
            icon: const Icon(Icons.delete),
            iconSize: 20,
          )
        : Container();
  }
}
