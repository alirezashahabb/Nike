import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/cart/bloc/cart_bloc.dart';
import 'package:flutter_application_1/ui/widgets/image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/cart_repositroy.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          var bloc = CartBloc(cartRepository);
          bloc.add(CartInitEvent());
          return bloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartSuccessState) {
              return ListView.builder(
                itemCount: state.cartResponse.cartItem.length,
                itemBuilder: (context, index) {
                  var items = state.cartResponse.cartItem[index];
                  return Container(
                    margin: const EdgeInsets.all(4),
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: ImageLoadingService(
                                imageUrl: items.product.imageUrl,
                                radius: 4,
                              ),
                            ),
                            Text(items.product.title)
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (state is CartErrorState) {
              return Text(state.appException.message);
            } else {
              throw Exception('state is not supported');
            }
          },
        ),
      ),
    );
  }
}
