import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/common/exceptions.dart';
import 'package:flutter_application_1/data/repo/cart_repositroy.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<CartEvent>(
      (event, emit) async {
        if (event is CartAddToBasketEvent) {
          try {
            emit(ProductAddToCatLoadingState());
            await Future.delayed(const Duration(seconds: 2));
            cartRepository.add(event.productId);
            emit(ProductAddToCartSuccess());
          } catch (e) {
            emit(ProductAddToCartError(exception: AppException()));
          }
        }
      },
    );
  }
}
