part of 'cart_bloc.dart';

sealed class CartState {
  const CartState();
}

final class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final CartResponse cartResponse;

  const CartSuccessState({required this.cartResponse});
}

class CartErrorState extends CartState {
  final AppException appException;

  const CartErrorState({required this.appException});
}

class CartAuthRequairedState extends CartState {}

/// this is for add cart
class CartEmptyState extends CartState {}
