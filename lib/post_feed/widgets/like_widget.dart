import 'package:flutter/material.dart';

class LikeWidget extends StatefulWidget {
  final Future<(bool, int)> currentState;
  const LikeWidget({
    required this.currentState,
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<(bool, int)>(
      future: widget.currentState,
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
          return _buildLikeWidget(state);
        }
      },
    );
  }

  Widget _buildLikeWidget((bool, int) state) {
    bool isLiked = state.$1;
    int likeCount = state.$2;
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
