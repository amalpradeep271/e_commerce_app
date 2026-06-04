class CouponEntity {
  final String id;
  final String code;
  final String discountType;
  final double discountValue;
  final double minOrderAmount;
  final double discountAmount;

  CouponEntity({
    required this.id,
    required this.code,
    required this.discountType,
    required this.discountValue,
    required this.minOrderAmount,
    required this.discountAmount,
  });
}
