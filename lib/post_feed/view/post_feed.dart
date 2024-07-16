import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:date_format/date_format.dart';
import '../widgets/image_carousel.dart';

class PostFeedWidget extends StatelessWidget {
  const PostFeedWidget({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PostFeedWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Post>>(
        stream: context.read<PostRepository>().retriveStream(isReply: false),
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
                  return Flexible(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      constraints:
                          const BoxConstraints(minHeight: 20, maxHeight: 400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                          displayDate(post.postDate),
                        ],
                      ),
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

  SizedBox displayDate(postDate) {
    return SizedBox(
      width: double.infinity,
      height: 20,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          parseDate(postDate),
          style: const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Flexible displayPostText(postText) {
    return Flexible(
      flex: 1,
      child: Text(
        postText,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic,
          color: Colors.black87,
        ),
      ),
    );
  }

  Flexible displayPosterId(posterId) {
    return Flexible(
      flex: 1,
      child: Row(
        children: [
          Text(
            posterId,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Expanded(
            child: Text(
              ' a postat:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
