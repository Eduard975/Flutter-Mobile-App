import 'package:date_format/date_format.dart';
import 'package:first_app/post_feed/widgets/image_carousel.dart';
import 'package:first_app/reply/view/reply_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

class DisplayPost {
  const DisplayPost();
  static String parseDate(String date) {
    DateTime myDate = DateTime.parse(date).toLocal();
    return formatDate(myDate, [HH, ':', nn, ' ', d, '-', MM, '-', yyyy]);
  }

  static Widget displayFeed(BuildContext context, String userId,
      [String? replyTo, Widget? topOfList]) {
    return StreamBuilder<List<Post>>(
      stream: context.read<PostRepository>().retriveStream(replyTo: replyTo),
      builder: (context, postsSnapshot) {
        // Handle different connection states
        if (postsSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (postsSnapshot.connectionState == ConnectionState.active ||
            postsSnapshot.connectionState == ConnectionState.done) {
          if (postsSnapshot.hasData && postsSnapshot.data!.isNotEmpty) {
            var itemCount = topOfList != null
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
                return DisplayPost.displayPost(context, post, userId, replyTo);
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

  static Widget displayPost(BuildContext context, Post post, String userId,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          displayPosterId(post.posterId, replyTo),
          displayPostText(post.postText),
          const Flexible(flex: 1, child: SizedBox(height: 10)),
          ImageCarousel(
            futureUrls:
                context.read<PostRepository>().retrivePostImages(post: post),
          ),
          const Flexible(flex: 1, child: SizedBox(height: 20)),
          displayBottomRow(context, post, userId),
        ],
      ),
    );
  }

  static Widget displayBottomRow(
      BuildContext context, Post post, String userId) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        displayDate(post.postDate),
        displayReplyBtn(context, post, userId),
      ],
    );
  }

  static Widget displayReplyBtn(
      BuildContext context, Post post, String userId) {
    return IntrinsicHeight(
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
        iconSize: 25,
      ),
    );
  }

  static Widget displayDate(String postDate) {
    return Text(
      parseDate(postDate),
      style: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
    );
  }

  static Widget displayPostText(String postText) {
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

  static Widget displayPosterId(String posterId, String? replyTo) {
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
