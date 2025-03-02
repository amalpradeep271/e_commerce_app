import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerCarouselSlider extends StatelessWidget {
  const BannerCarouselSlider(
      {super.key,
      required this.itemCount,
      required this.itemBuilder,
      required this.autoPlay,
      this.onPageChanged,
      required this.height,
      this.initialPage,
      this.carosuelController});
  final int itemCount;
  final Widget Function(BuildContext, int, int) itemBuilder;
  final bool autoPlay;
  final dynamic Function(int,CarouselPageChangedReason)?
      onPageChanged;
  final double height;
  final int? initialPage;
  final CarouselSliderController? carosuelController;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: carosuelController,
      itemCount: itemCount,
      itemBuilder: (context, index, _) {
        return itemBuilder(context, index, _);
      },
      options:CarouselOptions(
        initialPage: initialPage ?? 0,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        autoPlay: autoPlay,
        height: height,
        autoPlayAnimationDuration: const Duration(seconds: 2),
        onPageChanged: (index, _) {
          return onPageChanged!(index, _);
        },
      ),
    );
  }
}

// // import 'package:carousel_slider/carousel_slider.dart'  as carousel_slider;
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // class CustomAppCarouselSliders extends GetWidget {
// //   const CustomAppCarouselSliders(
// //       {super.key,P
// //       required this.itemCount,
// //       required this.itemBuilder,
// //       required this.autoPlay,
// //       this.onPageChanged,
// //       required this.height,
// //       this.initialPage,
// //       this.carosuelController});
// //   final int itemCount;
// //   final Widget Function(BuildContext, int, int) itemBuilder;
// //   final bool autoPlay;
// //   final dynamic Function(int, carousel_slider.CarouselPageChangedReason)? onPageChanged;
// //   final double height;
// //   final int? initialPage;
// //   final carousel_slider.CarouselController? carosuelController;
// //   @override
// //   Widget build(BuildContext context) {
// //     return carousel_slider.CarouselSlider.builder(
// //       carouselController: carosuelController,
// //       itemCount: itemCount,
// //       itemBuilder: (context, index, _) {
// //         return itemBuilder(context, index, _);
// //       },
// //       options:carousel_slider.CarouselOptions(
// //         initialPage: initialPage ?? 0,
// //         viewportFraction: 1,
// //         enableInfiniteScroll: false,
// //         autoPlay: autoPlay,
// //         height: height,
// //         autoPlayAnimationDuration: const Duration(seconds: 2),
// //         onPageChanged: (index, _) {
// //           return onPageChanged!(index, _);
// //         },
// //       ),
// //     );
// //   }
// // }
