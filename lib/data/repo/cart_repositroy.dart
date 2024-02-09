import 'package:flutter_application_1/common/http_client.dart';

import 'package:flutter_application_1/data/add_to_cart_response.dart';
import 'package:flutter_application_1/data/cart_response.dart';
import 'package:flutter_application_1/data/source/cart_data_source.dart';

final cartRepository = CartRepository(
  dataSource: CartItemRemoteDataSource(httpCline: httpClient),
);

abstract class ICartRepository {
  Future<AddToCartResponse> add(int id);
  Future<AddToCartResponse> changeCount(int count, int cartItem);
  Future<void> deleted(int cartItem);
  Future<int> count();
  Future<CartResponse> geAll();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository({required this.dataSource});
  @override
  Future<AddToCartResponse> add(int id) {
    return dataSource.add(id);
  }

  @override
  Future<AddToCartResponse> changeCount(int count, int cartItem) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> deleted(int cartItem) {
    // TODO: implement deleted
    throw UnimplementedError();
  }

  @override
  Future<CartResponse> geAll() => dataSource.geAll();
}
