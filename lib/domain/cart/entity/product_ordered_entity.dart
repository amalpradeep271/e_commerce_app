class ProductOrderedEntity {
  final String productId;
  final String productTitle;
  final num productQuantity;
  final String productColor;
  final String productSize;
  final num productPrice;
  final num discountPrice;
  final num totalPrice;
  final String productImage;
  final String createdDate;
  final String id;

  ProductOrderedEntity(
      {required this.productId,
      required this.productTitle,
      required this.productQuantity,
      required this.productColor,
      required this.productSize,
      required this.productPrice,
      required this.discountPrice,
      required this.totalPrice,
      required this.productImage,
      required this.createdDate,
      required this.id});
}
