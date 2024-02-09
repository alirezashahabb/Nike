import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/common/exceptions.dart';
import 'package:flutter_application_1/data/cart_response.dart';
import 'package:flutter_application_1/data/repo/cart_repositroy.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository repository;
  CartBloc(this.repository) : super(CartLoadingState()) {
    on<CartEvent>(
      (event, emit) async {
        try {
          if (event is CartInitEvent) {
            emit(CartLoadingState());
            final cartItems = await repository.geAll();
            emit(CartSuccessState(cartResponse: cartItems));
          }
        } catch (e) {
          emit(
            CartErrorState(
              appException: AppException(),
            ),
          );
        }
      },
    );
  }
}
