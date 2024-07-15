import 'package:flutter/material.dart';

class FullImagePage extends StatelessWidget {
  final String imgUrl;

  const FullImagePage({required this.imgUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.network(imgUrl),
      ),
    );
  }
}
