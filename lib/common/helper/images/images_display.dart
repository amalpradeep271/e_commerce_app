import 'package:e_commerce_application/core/constants/app_urls.dart';

class ImageDisplayHelper {
  static String generateCategoryImageURL(String title) {
    return AppUrl.categoryImage + title + AppUrl.alt;
  }

   static String generateBannerImageURL(String title) {
    return AppUrl.bannerImage + title + AppUrl.alt;
  }

  static String generateProductImageURL(String title) {
    return AppUrl.productImage + title + AppUrl.alt;
  }

    static String generateSingleProductImageURL(String title) {
    return AppUrl.productSelectImage + title + AppUrl.alt;
  }
}
