class AddToCartResponse {
  final int productId;
  final int cartItem;
  final int count;

  AddToCartResponse(this.productId, this.cartItem, this.count);

  factory AddToCartResponse.fromJson(Map<String, dynamic> jsonObject) {
    return AddToCartResponse(
      jsonObject['product_id'],
      jsonObject['id'],
      jsonObject['count'],
    );
  }
}
