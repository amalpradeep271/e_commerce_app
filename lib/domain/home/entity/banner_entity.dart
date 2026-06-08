class BannerEntity {
  final String bannerId;
  final String bannerImage;
  final String? title;
  final String? subtitle;
  final String? discountAmount;

  BannerEntity({
    required this.bannerId,
    required this.bannerImage,
    this.title,
    this.subtitle,
    this.discountAmount,
  });
}
