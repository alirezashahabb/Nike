class CartResponse {
  final int productId;
  final int cartItem;
  final int count;

  CartResponse(this.productId, this.cartItem, this.count);

  factory CartResponse.fromJson(Map<String, dynamic> jsonObject) {
    return CartResponse(
      jsonObject['product_id'],
      jsonObject['id'],
      jsonObject['count'],
    );
  }
}
