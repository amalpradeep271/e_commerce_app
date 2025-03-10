// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/common/bloc/button/button_state.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/core/constants/app_preference.dart';
import 'package:e_commerce_application/presentation/review/page/all_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_text_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/data/review/model/add_review_req_model.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/review/usecase/add_to_review_usecase.dart';
import 'package:e_commerce_application/presentation/review/bloc/rating_cubit.dart';

class ReviewForm extends StatelessWidget {
  ReviewForm({
    super.key,
    required this.productEntity,
  });
  final ProductEntity productEntity;

  final reviewValidator = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatingCubit(),
      child: BlocListener<ButtonStateCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonFailureState) {
            var snackbar = SnackBar(
              content: Text(
                state.errorMessage,
              ),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
          if (state is ButtonSuccessState) {
            var snackbar = SnackBar(
              content: Text(
                state.successMessage,
              ),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            _reviewController.clear();
            context.read<RatingCubit>().changeRating(0);
          }
        },
        child: BlocBuilder<RatingCubit, double>(
          builder: (context, rating) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reviews",
                      style: AppTextStyles.base.s16.w600,
                    ),
                    GestureDetector(
                      onTap: () {
                        AppNavigator.push(
                          context,
                          AllReviewPage(
                            productEntity: productEntity,
                          ),
                        );
                      },
                      child: Text(
                        "All Reviews",
                        style: AppTextStyles.base.s16.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RatingBar.builder(
                  itemSize: 25,
                  itemBuilder: (context, index) {
                    return const Icon(
                      Icons.star,
                      color: AppColors.kPrimaryColor,
                    );
                  },
                  onRatingUpdate: (newRating) {
                    context.read<RatingCubit>().changeRating(newRating);
                    log(context.read<RatingCubit>().state.toString());
                  },
                  itemCount: 5,
                  minRating: 0,
                  initialRating: rating,
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: reviewValidator,
                  child: TextFormField(
                    controller: _reviewController,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            "Share the details of your own experience on this product"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'cannot post empty review type something';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BasicTextButton(
                      onPressed: () async {
                        final pref = AppPref();
                        String? userImage =
                            await pref.imageStorage.read(key: pref.imageKey);
                        String? userName =
                            await pref.nameStorage.read(key: pref.nameKey);
                        if (reviewValidator.currentState!.validate()) {
                          if (context.mounted) {
                            context.read<ButtonStateCubit>().execute(
                                  usecase: AddReviewUseCase(),
                                  params: AddReviewReqModel(
                                    userImage: userImage.toString(),
                                    userName: userName.toString(),
                                    createdDate:
                                        Timestamp.fromDate(DateTime.now()),
                                    productId: productEntity.productId,
                                    rating: context.read<RatingCubit>().state,
                                    review: _reviewController.text,
                                  ),
                                );
                          }
                        }
                      },
                      title: 'Submit',
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
