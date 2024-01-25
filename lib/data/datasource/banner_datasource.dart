import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/validator_responce.dart';
import 'package:flutter_application_1/data/module/banner_module.dart';

abstract class IBannerDataSource{
Future <List<BannerEntity>> getBanner();
}
class BannerRemoteDataSource with Validator implements IBannerDataSource{
  final Dio httpClient ;

  BannerRemoteDataSource({required this.httpClient}); 
  @override
  Future<List<BannerEntity>> getBanner() async {
      Response response  = await httpClient.get('banner/slider');
      validatorResponse(response);
final banner = <BannerEntity> [];
      for (var element in (response.data as List)) {
        banner.add(BannerEntity.fromJson(element));
      }
      return banner;
  }

}