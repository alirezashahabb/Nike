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
