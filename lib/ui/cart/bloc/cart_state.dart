part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final CartResponse cartResponse;

  const CartSuccessState({required this.cartResponse});
  @override
  // TODO: implement props
  List<Object> get props => [cartResponse];
}

class CartErrorState extends CartState {
  final AppException appException;

  const CartErrorState({required this.appException});
  @override
  // TODO: implement props
  List<Object> get props => [appException];
}

class CartAuthRequairedState extends CartState {}

/// this is for add cart
class CartEmptyState extends CartState {}
