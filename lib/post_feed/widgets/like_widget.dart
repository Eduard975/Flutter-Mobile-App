import 'package:flutter/material.dart';

class LikeWidget extends StatefulWidget {
  final (bool, int) currentState;
  const LikeWidget({
    required this.currentState,
    super.key,
  });

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  bool isLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    isLiked = widget.currentState.$1;
    likeCount = widget.currentState.$2;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildLikeWidget();
  }

  Widget _buildLikeWidget() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          IntrinsicHeight(
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (isLiked) {
                    likeCount--;
                  } else {
                    likeCount++;
                  }
                  isLiked = !isLiked; // Toggle the icon color
                });
              },
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.grey,
              ),
              iconSize: 35,
            ),
          ),
          Text(
            '$likeCount', // Display the updated count
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
