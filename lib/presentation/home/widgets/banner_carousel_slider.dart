// ignore_for_file: no_wildcard_variable_uses

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_application/presentation/home/bloc/banner_carousel_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerCarouselSlider extends StatelessWidget {
  const BannerCarouselSlider(
      {super.key,
      required this.itemCount,
      required this.itemBuilder,
      required this.autoPlay,
      required this.height,
      this.initialPage,
      this.carosuelController});
  final int itemCount;
  final Widget Function(BuildContext, int, int) itemBuilder;
  final bool autoPlay;
  final double height;
  final int? initialPage;
  final CarouselSliderController? carosuelController;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarouselCubit(),
      child: BlocBuilder<CarouselCubit, int>(
        builder: (context, state) {
          return CarouselSlider.builder(
            carouselController: carosuelController,
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
              autoPlayAnimationDuration: const Duration(seconds: 2),
              onPageChanged: (index, _) {
                context.read<CarouselCubit>().onIndexChange(index);
              },
            ),
          );
        },
      ),
    );
  }
}
