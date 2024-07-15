import 'package:first_app/full_image/full_image_page.dart';
import 'package:flutter/material.dart';
// import 'dart:developer' as developer;

class ImageCarousel extends StatefulWidget {
  final Future<List<String>> futureUrls;

  const ImageCarousel({
    super.key,
    required this.futureUrls,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int activePage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: widget.futureUrls,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading images: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container();
        } else {
          List<String> imageUrls = snapshot.data!;
          return _buildImageCarousel(imageUrls);
        }
      },
    );
  }

  Widget _buildImageCarousel(List<String> imageUrls) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.60,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            itemCount: imageUrls.length,
            controller: PageController(viewportFraction: 0.8),
            pageSnapping: true,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(10),
                child: InkWell(
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FullImagePage(imgUrl: imageUrls[index]),
                            ),
                          ),
                        },
                    child: Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                    )),
                //child: AspectRatio(
                //   aspectRatio: MediaQuery.of(context).size.width /
                //       MediaQuery.of(context).size.height,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         fit: BoxFit.fitWidth,
                //         alignment: FractionalOffset.topCenter,
                //         image: NetworkImage(imageUrls[index]),
                //       ),
                //     ),
                //   ),
                // ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(imageUrls.length, activePage),
        )
      ],
    );
  }

  List<Widget> indicators(int imagesLength, int currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle,
        ),
      );
    });
  }
}