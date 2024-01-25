part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}





class HomeErrorState extends HomeState{
  final AppException exception ;

  const HomeErrorState({required this.exception}); 

  @override
  // TODO: implement props
  List<Object> get props => [exception];
}

class HomeResponseState extends HomeState{

   final List<BannerEntity> banners;
   final List<ProductEntity> latest;
   final List<ProductEntity> popular;

 const  HomeResponseState({required this.banners, required this.latest, required this.popular});



}

