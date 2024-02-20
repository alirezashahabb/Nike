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
                emit(CartSuccessState(cartResponse: succesState.cartResponse));
              }
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        } else if (event is CartAuthInfoChangeEvent) {
          if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
            emit(
              CartAuthRequairedState(),
            );
          } else {
            if (state is CartAuthRequairedState) {
              await loadCartItem(emit, false);
            }
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
}
