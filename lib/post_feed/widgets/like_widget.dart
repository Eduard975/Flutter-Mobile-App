import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

class LikeWidget extends StatefulWidget {
  final Post post;
  final String userId;
  const LikeWidget({
    required this.post,
    required this.userId,
    super.key,
  });

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool btnPress = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<(bool, int)>(
      future: context.read<PostRepository>().updatePostLikes(
            post: widget.post,
            userId: widget.userId,
            btnPress: btnPress,
          ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading likes: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Nu am putut gasi')),
            );
          return SizedBox(
              height: 1, width: double.infinity, child: Container());
        } else {
          (bool, int) state = snapshot.data!;
          return _buildLikeWidget(state.$1, state.$2);
        }
      },
    );
  }

  Widget _buildLikeWidget(bool isLiked, int likeCount) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          IntrinsicHeight(
            child: IconButton(
              onPressed: () {
                setState(() {
                  btnPress = true;
                });
              },
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.red,
              ),
              iconSize: 35,
            ),
          ),
          Text(
            '$likeCount',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 16, 8, 8),
            ),
          ),
        ],
      ),
    );
  }
}
