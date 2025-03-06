// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:flutter/widgets.dart';

import 'package:e_commerce_application/domain/product/entity/product_entity.dart';

class ProductTitle extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductTitle({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      productEntity.title,
      style: AppTextStyles.base.s24.w500,
    );
  }
}
