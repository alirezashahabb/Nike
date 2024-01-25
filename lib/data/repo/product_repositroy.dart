

import 'package:flutter_application_1/common/http_clinet.dart';
import 'package:flutter_application_1/data/datasource/prdoduct_datasorce.dart';
import 'package:flutter_application_1/data/module/product_module.dart';

/// this class for 



final repository = ProductRepository(ProductRemoteDataSource(httpCline: httpClient),);

abstract class IProductRepository{
Future<List<ProductEntity>> getAll(int sort);
Future<List<ProductEntity>> search(String keyTeam);
}

class ProductRepository implements IProductRepository{
  final IProductDataSource dataSource ;

  ProductRepository(this.dataSource); 
  @override
  Future<List<ProductEntity>> getAll(int sort) => dataSource.getAll(sort);

  @override
  Future<List<ProductEntity>> search(String keyTeam) => dataSource.search(keyTeam);

}