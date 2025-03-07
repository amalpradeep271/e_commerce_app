import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class AllReviewPage extends StatelessWidget {
  const AllReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "All Reviews",
      ),
      body: reviewbody(),
    );
  }

  Widget reviewbody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "People Said",
                style: AppTextStyles.base.w700,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Stack(
                      children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                "https://img.freepik.com/premium-vector/user-profile-icon-flat-style-member-avatar-vector-illustration-isolated-background-human-permission-sign-business-concept_157943-15752.jpg?w=740")),
                        Positioned(
                            right: 20,
                            child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    "https://img.freepik.com/premium-vector/user-profile-icon-flat-style-member-avatar-vector-illustration-isolated-background-human-permission-sign-business-concept_157943-15752.jpg?w=740"))),
                        Positioned(
                            right: 5,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  "https://img.freepik.com/premium-vector/user-profile-icon-flat-style-member-avatar-vector-illustration-isolated-background-human-permission-sign-business-concept_157943-15752.jpg?w=740"),
                            )),
                      ],
                    ),
                  ),
                  Text(
                    "+${("len").toString()}",
                    style: AppTextStyles.base.w600,
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://img.freepik.com/premium-vector/user-profile-icon-flat-style-member-avatar-vector-illustration-isolated-background-human-permission-sign-business-concept_157943-15752.jpg?w=740"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "lkll",
                              style: AppTextStyles.base.s16.w600,
                            ),
                            Text(
                              DateFormat('dd MMM yyyy', 'en_US').format(
                                  DateTime.parse(DateTime.now().toString())),
                              style: AppTextStyles.base.w600.s12,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              ";l;l;",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RatingBarIndicator(
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: AppColors.kPrimaryColor,
                              ),
                              itemCount: 5,
                              itemSize: 17,
                              direction: Axis.horizontal,
                              rating: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
              itemCount: 100,
            ),
          )
          // ListView.builder(
          //   // controller: controller.controller,
          //   itemCount: 10,
          //   itemBuilder: (context, index) {
          //     return Column(
          //       children: [
          //         Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             // const CircleAvatar(
          //             //   backgroundImage: NetworkImage(
          //             //       "https://img.freepik.com/premium-vector/user-profile-icon-flat-style-member-avatar-vector-illustration-isolated-background-human-permission-sign-business-concept_157943-15752.jpg?w=740"),
          //             // ),
          //             const SizedBox(
          //               width: 20,
          //             ),
          //             Expanded(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "lkll",
          //                     style: AppTextStyles.base.s16.w600,
          //                   ),
          //                   // Text(
          //                   //   DateFormat('dd MMM yyyy', 'en_US')
          //                   //       .format(DateTime.parse(
          //                   //           controller
          //                   //               .getreviewList[index]
          //                   //               .createdAt
          //                   //               .toString())),
          //                   //   style: AppTextStyles.base.w600.s12,
          //                   // ),
          //                   const SizedBox(
          //                     height: 10,
          //                   ),
          //                   Text(
          //                     ";l;l;",
          //                   ),
          //                   const SizedBox(
          //                     height: 10,
          //                   ),
          //                   RatingBarIndicator(
          //                     itemBuilder: (context, index) => const Icon(
          //                       Icons.star,
          //                       color: AppColors.kPrimaryColor,
          //                     ),
          //                     itemCount: 5,
          //                     itemSize: 17,
          //                     direction: Axis.horizontal,
          //                     rating: 1,
          //                     // rating: controller
          //                     //     .getreviewList[index].rating!
          //                     //     .toDouble(),
          //                   ),
          //                   const SizedBox(
          //                     height: 10,
          //                   ),
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //         const Divider(),
          //         const SizedBox(
          //           height: 20,
          //         ),
          //       ],
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
