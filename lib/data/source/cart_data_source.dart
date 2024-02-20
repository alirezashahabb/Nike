import 'package:dio/dio.dart';

import 'package:flutter_application_1/data/add_to_cart_response.dart';
import 'package:flutter_application_1/data/cart_response.dart';
import 'package:flutter_application_1/data/common/http_response_validator.dart';

abstract class ICartDataSource {
  Future<AddToCartResponse> add(int id);
  Future<AddToCartResponse> changeCount(int count, int cartItem);
  Future<void> deleted(int cartItem);
  Future<int> count();
  Future<CartResponse> geAll();
}

class CartItemRemoteDataSource
    with HttpResponseValidator
    implements ICartDataSource {
  final Dio httpCline;

  CartItemRemoteDataSource({required this.httpCline});
  @override
  Future<AddToCartResponse> add(int id) async {
    Response response = await httpCline.post(
      'cart/add',
      data: {
        'product_id': id,
      },
    );
    return AddToCartResponse.fromJson(response.data);
  }

  @override
  Future<AddToCartResponse> changeCount(int count, int cartItem) async {
    final Response response = await httpCline.post('cart/changeCount', data: {
      "cart_item_id": cartItem,
      "count": count,
    });
    return AddToCartResponse.fromJson(response.data);
  }

  @override
  Future<int> count() async {
    // TODO: implement deleted
    throw UnimplementedError();
  }

  @override
  Future<void> deleted(int cartItem) {
    return httpCline.post('cart/remove', data: {"cart_item_id": cartItem});
  }

  @override
  Future<CartResponse> geAll() async {
    final response = await httpCline.get('cart/list');
    return CartResponse.fromJson(response.data);
  }
}
