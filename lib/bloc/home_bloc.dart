import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/common/exception.dart';
import 'package:flutter_application_1/data/module/banner_module.dart';
import 'package:flutter_application_1/data/module/product_module.dart';
import 'package:flutter_application_1/data/repo/banner_repositroy.dart';
import 'package:flutter_application_1/data/repo/product_repositroy.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository ; 
  final IProductRepository productRepository;
  HomeBloc(this.bannerRepository , this.productRepository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async{
    if(event is HomeStartedEvent || event is HomeRefreshEvent){
    try {
        emit(HomeInitial(),
      );

      final banners = await bannerRepository.getBanner();
      final leates = await productRepository.getAll(ProductSort.leatst);
      final popular = await productRepository.getAll(ProductSort.popular);
      emit(HomeResponseState(banners: banners, latest: leates, popular: popular));
    } catch (e) {
      emit(HomeErrorState(exception: e is AppException ? e : AppException(message: 'خطا نا مشخص')));
    }



   }
    });
  }
}
