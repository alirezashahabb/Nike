part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class ProductAddToCatLoadingState extends CartState {}

class ProductAddToCartError extends CartState {
  final AppException exception;

  const ProductAddToCartError({required this.exception});

  @override
  List<Object> get props => [exception];
}

class ProductAddToCartSuccess extends CartState {}
