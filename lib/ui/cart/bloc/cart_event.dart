part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitEvent extends CartEvent {
  final AuthInfo? authInfo;
  final bool isRefresh;

  const CartInitEvent({required this.authInfo, this.isRefresh = false});
}

/// یا این تغبرات چه state  هایی باید ایجاد شود
class CartAuthInfoChangeEvent extends CartEvent {
  final AuthInfo? authInfo;

  const CartAuthInfoChangeEvent({required this.authInfo});
}

class CartDeletedButtonEvent extends CartEvent {
  final int productId;

  @override
  // TODO: implement props
  List<Object> get props => [productId];

  const CartDeletedButtonEvent({required this.productId});
}

/// this is for Increasment Count
class IncreaCountBottnClickedEvent extends CartEvent {
  final int productId;

  const IncreaCountBottnClickedEvent({required this.productId});

  @override
  // TODO: implement props
  List<Object> get props => [productId];
}

/// this is for Decrease Count
class DecreaseCountBottnClickedEvent extends CartEvent {
  final int productId;

  const DecreaseCountBottnClickedEvent({required this.productId});

  @override
  // TODO: implement props
  List<Object> get props => [productId];
}
