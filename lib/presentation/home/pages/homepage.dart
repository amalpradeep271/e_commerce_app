import 'package:e_commerce_application/presentation/home/widgets/categories.dart';
import 'package:e_commerce_application/presentation/home/widgets/header.dart';
import 'package:e_commerce_application/presentation/home/widgets/new_in.dart';
import 'package:e_commerce_application/presentation/home/widgets/search_field.dart';
import 'package:e_commerce_application/presentation/home/widgets/top_selling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          // const Header(),
          // SizedBox(height: 24.h),
          // const SearchField(),
          // SizedBox(height: 24.h),
          // const Categories(),
          // SizedBox(height: 24.h),
          // const TopSelling(),
          // SizedBox(height: 24.h),
          // const NewIn(),
        ],
      )),
    );
  }
}
