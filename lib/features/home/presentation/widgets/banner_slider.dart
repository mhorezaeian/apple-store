import 'package:apple_store/core/constants/myColor.dart';
import 'package:apple_store/core/widgets/cached_image.dart';
import 'package:apple_store/features/home/domain/entities/Home_banner.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final List<HomeBanner> banners;

  const BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    var bannerController = PageController(
      viewportFraction: 0.85,
      initialPage: 1,
    );
    return SliverToBoxAdapter(
      child: Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: bannerController,
              itemCount: banners.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    top: 8,
                  ),
                  child: Container(
                    // height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CachedImage(
                      imageUrl: banners[index].imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            child: SmoothPageIndicator(
              controller: bannerController, // PageController
              count: 3,
              effect: ExpandingDotsEffect(
                expansionFactor: 4,
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Colors.white,
                activeDotColor: Mycolor.blueIndicator,
              ), // your preferred effect
              onDotClicked: (index) {},
            ),
          ),
        ],
      ),
    );
  }
}
