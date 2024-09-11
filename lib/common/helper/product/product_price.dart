import 'package:e_commerce_application/domain/product/entity/product_entity.dart';

class ProductPriceHelper {
  static double provideCurrentPrice(ProductEntity product) {
    return product.discountPrice != 0
        ? product.discountPrice.toDouble()
        : product.price.toDouble();
  }
}
