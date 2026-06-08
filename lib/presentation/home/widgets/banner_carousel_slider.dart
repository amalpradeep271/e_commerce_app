// ignore_for_file: no_wildcard_variable_uses

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_application/presentation/home/bloc/banners/banner_carousel_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerCarouselSlider extends StatelessWidget {
  const BannerCarouselSlider({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.autoPlay,
    required this.height,
    this.initialPage,
    this.carouselController,
  });
  final int itemCount;
  final Widget Function(BuildContext, int, int) itemBuilder;
  final bool autoPlay;
  final double height;
  final int? initialPage;
  final CarouselSliderController? carouselController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarouselCubit(),
      child: BlocBuilder<CarouselCubit, int>(
        builder: (context, activeIndex) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final activeColor = isDark ? const Color(0xFF14B8A6) : const Color(0xFF006970);

          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: itemCount,
                itemBuilder: (context, index, _) {
                  return itemBuilder(context, index, _);
                },
                options: CarouselOptions(
                  initialPage: initialPage ?? 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  autoPlay: autoPlay,
                  height: height,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayInterval: const Duration(seconds: 5),
                  onPageChanged: (index, _) {
                    context.read<CarouselCubit>().onIndexChange(index);
                  },
                ),
              ),
              Positioned(
                bottom: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    itemCount,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: activeIndex == index ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: activeIndex == index
                            ? activeColor
                            : Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
