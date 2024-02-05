import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/cart_list.dart';
import 'package:flutter_application_1/data/cart_responce.dart';
import 'package:flutter_application_1/data/common/http_response_validator.dart';

abstract class ICartDataSource {
  Future<CartResponse> add(int id);
  Future<CartResponse> changeCount(int count, int cartItem);
  Future<void> deleted(int cartItem);
  Future<int> count();
  Future<List<CartItemEntity>> geAll();
}

class CartItemRemoteDataSource
    with HttpResponseValidator
    implements ICartDataSource {
  final Dio httpCline;

  CartItemRemoteDataSource({required this.httpCline});
  @override
  Future<CartResponse> add(int id) async {
    Response response = await httpCline.post(
      'cart/add',
      data: {
        'product_id': id,
      },
    );
    return CartResponse.fromJson(response.data);
  }

  @override
  Future<CartResponse> changeCount(int count, int cartItem) async {
    final Response response = await httpCline.post('cart/changeCount', data: {
      "cart_item_id": cartItem,
      "count": count,
    });
    return CartResponse.fromJson(response.data);
  }

  @override
  Future<int> count() async {
    // TODO: implement deleted
    throw UnimplementedError();
  }

  @override
  Future<void> deleted(int cartItem) {
    // TODO: implement deleted
    throw UnimplementedError();
  }

  @override
  Future<List<CartItemEntity>> geAll() {
    // TODO: implement geAll
    throw UnimplementedError();
  }
}
