part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAddToBasketEvent extends CartEvent {
  final int productId;

  const CartAddToBasketEvent({required this.productId});
}
