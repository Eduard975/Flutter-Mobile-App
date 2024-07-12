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

  // TODO: Refractor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: context.read<PostRepository>().retrivePosts(),
        builder: (context, postsSnapshot) {
          if (postsSnapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: postsSnapshot.data?.length,
              itemBuilder: (context, index) {
                final post = postsSnapshot.data![index];
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            postsSnapshot.data![index].posterId,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const Text(
                            ' a postat:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      ImageCarousel(
                        futureUrls: context
                            .read<PostRepository>()
                            .retrivePostImages(
                                post: postsSnapshot.data![index]),
                      ),
                      Text(
                        post.postText,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          parseDate(postsSnapshot.data![index].postDate),
                          style: const TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else if (postsSnapshot.hasError) {
            return Center(
                child: Text('Problem loading posts: ${postsSnapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  String parseDate(String date) {
    DateTime myDate = DateTime.parse(date);

    return formatDate(myDate, [HH, ':', nn, ' ', d, '-', MM, '-', yyyy]);
  }
}
