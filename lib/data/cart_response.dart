import 'package:flutter_application_1/data/cart_list.dart';

/// this class for CartItems List
class CartResponse {
  final List<CartItemEntity> cartItem;
  final int payablePrice;
  final int totalPrice;
  final int shippingCost;

  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItem = CartItemEntity.parseJsonArray(json['cart_items']),
        payablePrice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingCost = json['shipping_cost'];
}
