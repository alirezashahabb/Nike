import 'package:dio/dio.dart';

import 'package:flutter_application_1/common/validator_responce.dart';
import 'package:flutter_application_1/data/module/product_module.dart';


/// ===============================================>>>>this class for DataSource 

abstract class IProductDataSource{
Future<List<ProductEntity>> getAll(int sort);
Future<List<ProductEntity>> search(String keyTeam);
}

class ProductRemoteDataSource with Validator implements IProductDataSource{
  final Dio httpCline ;

  ProductRemoteDataSource({required this.httpCline}); 
  @override
  Future<List<ProductEntity>> getAll(int sort) async {
  Response response = await httpCline.get('/product/list?sort=$sort');
  validatorResponse(response);
  final product = <ProductEntity> [];
  for (var element in (response.data as List)) {
      product.add(ProductEntity.fromJson(element));
  }
  return product;
  }

  @override
  Future<List<ProductEntity>> search(String keyTeam) async {
   Response response = await httpCline.get('/product/search?q=$keyTeam');
  validatorResponse(response);
  final product = <ProductEntity> [];
  for (var element in (response.data as List)) {
      product.add(ProductEntity.fromJson(element));
  }
  return product;
  }

}

