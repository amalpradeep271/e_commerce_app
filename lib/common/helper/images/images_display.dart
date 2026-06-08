import 'package:e_commerce_application/core/constants/app_urls.dart';

class ImageDisplayHelper {
  static String generateCategoryImageURL(String image) {
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }
    return AppUrl.categoryImage + image + AppUrl.alt;
  }

   static String generateBannerImageURL(String image) {
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }
    return AppUrl.bannerImage + image + AppUrl.alt;
  }

  static String generateProductImageURL(String image) {
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }
    return AppUrl.productImage + image + AppUrl.alt;
  }

    static String generateSingleProductImageURL(String image) {
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }
    return AppUrl.productSelectImage + image + AppUrl.alt;
  }
}
