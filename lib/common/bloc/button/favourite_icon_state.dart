class FavoriteIconState {
  final bool isFavorite;
  final String productId;

  FavoriteIconState({required this.isFavorite, required this.productId});

  FavoriteIconState copyWith({bool? isFavorite}) {
    return FavoriteIconState(
      isFavorite: isFavorite ?? this.isFavorite,
      productId: productId,
    );
  }
}
