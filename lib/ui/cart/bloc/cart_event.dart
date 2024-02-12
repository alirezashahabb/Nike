part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitEvent extends CartEvent {
  /// for chacke user is login or no
  final AuthInfo? authInfo;

  const CartInitEvent({required this.authInfo});
}

class CartAuthInfoChangeEvent extends CartEvent {
  final AuthInfo? authInfo;

  const CartAuthInfoChangeEvent({required this.authInfo});
}
