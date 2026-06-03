import 'package:e_commerce_application/common/widgets/product/product_section.dart';
import 'package:e_commerce_application/domain/product/usecase/get_newin_usecase.dart';
import 'package:e_commerce_application/presentation/all_products/pages/all_new_products_page.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/material.dart';

class NewIn extends StatelessWidget {
  const NewIn({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductSection(
      heading: "New In",
      useCase: sl<GetNewInUseCase>(),
      seeAllPage: const AllNewProductsPage(
        title: "New In",
      ),
    );
  }
}
