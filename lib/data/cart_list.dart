import 'package:flutter_application_1/data/product.dart';

class CartItemEntity {
  final ProductEntity product;
  final int id;
  final int count;
  bool deletedButtonLoading = false;

  CartItemEntity.fromJson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json['product']),
        id = json['cart_item_id'],
        count = json['count'];

  /// get all products items
  static List<CartItemEntity> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartItemEntity> cartItems = [];

    for (var element in jsonArray) {
      cartItems.add(CartItemEntity.fromJson(element));
    }
    return cartItems;
  }
}
