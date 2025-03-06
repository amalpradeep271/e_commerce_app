import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBars extends StatelessWidget {
  const RatingBars({super.key,required this.rating,});
final double rating;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: AppColors.kPrimaryColor,
      ),
      itemCount: 5,
      itemSize:20,
      direction: Axis.horizontal,
      rating: rating,
    );
  }
}