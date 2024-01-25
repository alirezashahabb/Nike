import 'package:flutter_application_1/common/http_clinet.dart';
import 'package:flutter_application_1/data/datasource/banner_datasource.dart';
import 'package:flutter_application_1/data/module/banner_module.dart';


final banner = BannerRepository(BannerRemoteDataSource(httpClient: httpClient));

/// this class for banner Repository
abstract class IBannerRepository{
Future <List<BannerEntity>> getBanner();
}

class BannerRepository implements IBannerRepository{
  final IBannerDataSource bannerDataSource ;

  BannerRepository(this.bannerDataSource); 
  @override
  Future<List<BannerEntity>> getBanner()  => bannerDataSource.getBanner();

}