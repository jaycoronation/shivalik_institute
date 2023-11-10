import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constant/colors.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final List<String>? images;
  final int selectedIndex;

  const FullScreenImage(this.imageUrl, this.images, this.selectedIndex,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController? controller = PageController(initialPage: selectedIndex);
    return Scaffold(
        backgroundColor: const Color(0XffEDEDEE),
        body: Container(
          color: const Color(0XffEDEDEE),
          child: images!.isEmpty
              ? Stack(
                  children: [
                    Center(
                      child: PhotoView(
                          imageProvider: NetworkImage(
                            imageUrl,
                          ),
                          loadingBuilder: (context, event) => Image.asset(
                                'assets/images/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                          enablePanAlways: true,
                          backgroundDecoration:
                              const BoxDecoration(color: Color(0XffEDEDEE))),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 42, right: 12),
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_rounded),
                        color: Colors.black,
                        iconSize: 32,
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    PhotoViewGallery.builder(
                      itemCount: images!.length,
                      pageController: controller,
                      loadingBuilder: (context, event) => Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.contain,
                      ),
                      builder: (context, index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider:
                              NetworkImage(images![index] + "&w=720"),
                          initialScale: PhotoViewComputedScale.contained,
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 2,
                        );
                      },
                      scrollPhysics: const BouncingScrollPhysics(),
                      backgroundDecoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 42, right: 12),
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_rounded),
                        color: Colors.black,
                        iconSize: 32,
                      ),
                    ),
                    images!.length > 1
                        ? Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.all(18),
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: images!.length,
                              effect:  ExpandingDotsEffect(
                                dotHeight: 7,
                                dotWidth: 7,
                                activeDotColor: black,
                                dotColor: grayLight,
                                // strokeWidth: 5,
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
        )
    );
  }
}
