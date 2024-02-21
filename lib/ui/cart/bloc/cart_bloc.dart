import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/exceptions.dart';
import 'package:flutter_application_1/data/auth_info.dart';
import 'package:flutter_application_1/data/cart_response.dart';

import 'package:flutter_application_1/data/repo/cart_repositroy.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository repository;
  CartBloc(this.repository) : super(CartLoadingState()) {
    on<CartEvent>(
      (event, emit) async {
        if (event is CartInitEvent) {
          final auth = event.authInfo;
          if (auth == null || auth.accessToken.isEmpty) {
            emit(CartAuthRequairedState());
          } else {
            await loadCartItem(emit, event.isRefresh);
          }

          ///this is for button deleted clicked in cart
        } else if (event is CartDeletedButtonEvent) {
          try {
            if (state is CartSuccessState) {
              final succesState = (state as CartSuccessState);
              final cartItem = succesState.cartResponse.cartItem
                  .firstWhere((element) => element.id == event.productId);
              cartItem.deletedButtonLoading = true;
              emit(CartSuccessState(cartResponse: succesState.cartResponse));
            }
            await repository.deleted(event.productId);
            if (state is CartSuccessState) {
              final succesState = (state as CartSuccessState);
              succesState.cartResponse.cartItem
                  .removeWhere((element) => element.id == event.productId);
              if (succesState.cartResponse.cartItem.isEmpty) {
                emit(CartEmptyState());
              } else {
                ///this is for calculatro price
                emit(calculatroPrice(succesState.cartResponse));
              }
            }
          } catch (e) {
            debugPrint(e.toString());
          }

          /// this is for Increascount and DeacreCount botton
        } else if (event is IncreaCountBottnClickedEvent ||
            event is DecreaseCountBottnClickedEvent) {
          try {
            int cartItemId = 0;
            if (event is IncreaCountBottnClickedEvent) {
              cartItemId = event.productId;
            } else if (event is DecreaseCountBottnClickedEvent) {
              cartItemId = event.productId;
            }

            if (state is CartSuccessState) {
              final successState = (state as CartSuccessState);
              final index = successState.cartResponse.cartItem
                  .indexWhere((element) => element.id == cartItemId);
              successState.cartResponse.cartItem[index].changeCountLoading =
                  true;
              emit(CartSuccessState(cartResponse: successState.cartResponse));

              await Future.delayed(const Duration(milliseconds: 2000));
              final newCount = event is IncreaCountBottnClickedEvent
                  ? ++successState.cartResponse.cartItem[index].count
                  : --successState.cartResponse.cartItem[index].count;

              await cartRepository.changeCount(cartItemId, newCount);

              successState.cartResponse.cartItem
                  .firstWhere((element) => element.id == cartItemId)
                ..count = newCount
                ..changeCountLoading = false;

              emit(calculatroPrice(successState.cartResponse));
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      },
    );
  }

  /// this is for load Cart
  Future<void> loadCartItem(Emitter<CartState> emit, bool isRefresh) async {
    try {
      if (!isRefresh) {
        emit(CartLoadingState());
      }
      final res = await repository.geAll();
      if (res.cartItem.isEmpty) {
        emit(CartEmptyState());
      } else {
        emit(CartSuccessState(cartResponse: res));
      }
      emit(CartSuccessState(cartResponse: res));
    } catch (e) {
      emit(CartErrorState(appException: AppException()));
    }
  }

  /// محاسبه جمع نهایی سبد خرید بدون درخواست زذن به سرور
  CartSuccessState calculatroPrice(CartResponse cartResponse) {
    int payablePrice = 0;
    int totalPrice = 0;
    int shippingCost = 0;

    for (var cartItem in cartResponse.cartItem) {
      totalPrice += cartItem.product.previousPrice * cartItem.count;
      payablePrice += cartItem.product.price * cartItem.count;
    }
    shippingCost = payablePrice > 50000 ? 0 : 10000;

    cartResponse.payablePrice = payablePrice;
    cartResponse.shippingCost = shippingCost;
    cartResponse.totalPrice = totalPrice;
    return CartSuccessState(cartResponse: cartResponse);
  }
}
