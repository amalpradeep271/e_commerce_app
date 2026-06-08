import 'package:e_commerce_application/common/widgets/product/product_section.dart';
import 'package:e_commerce_application/domain/product/usecase/get_topselling_usecase.dart';
import 'package:e_commerce_application/presentation/all_products/pages/all_top_selling_products_page.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/material.dart';

class TopSelling extends StatelessWidget {
  const TopSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductSection(
      heading: "Top Selling",
      useCase: sl<GetTopSellingUseCase>(),
      seeAllPage: const AllTopSellingProductsPage(
        title: "Top Selling",
      ),
    );
  }
}
