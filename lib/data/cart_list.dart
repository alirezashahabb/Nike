import 'package:flutter_application_1/data/product.dart';

class CartItemEntity {
  final ProductEntity product;
  final int id;
  final int count;

  CartItemEntity.fromJson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json),
        id = json['cart_item_id'],
        count = json['count'];
}
