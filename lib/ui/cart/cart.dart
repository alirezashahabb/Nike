import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/utils.dart';
import 'package:flutter_application_1/data/repo/auth_repository.dart';
import 'package:flutter_application_1/ui/auth/auth.dart';
import 'package:flutter_application_1/ui/cart/bloc/cart_bloc.dart';
import 'package:flutter_application_1/ui/widgets/image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/cart_repositroy.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
  @override
  void initState() {
    AuthRepository.authChangeNotifier.addListener(authChangeNotifier);
    super.initState();
  }

  void authChangeNotifier() {
    cartBloc?.add(CartAuthInfoChangeEvent(
        authInfo: AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier.removeListener(authChangeNotifier);
    super.dispose();
    cartBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          var bloc = CartBloc(cartRepository);
          cartBloc = bloc;
          bloc.add(
            CartInitEvent(
              authInfo: AuthRepository.authChangeNotifier.value,
            ),
          );
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
                    margin: const EdgeInsets.all(9),
                    width: MediaQuery.of(context).size.width,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageLoadingService(
                                  imageUrl: items.product.imageUrl,
                                  radius: 4,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(items.product.title),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('تعداد',
                                      style: themeData.textTheme.bodySmall),
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.add,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(items.count.toString()),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.remove,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    items.product.previousPrice.withPriceLabel,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough),
                                  ),
                                  Text(items.product.price.withPriceLabel),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text('حذف از سبد خرید'))
                      ],
                    ),
                  );
                },
              );
            } else if (state is CartAuthRequairedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ورود به حساب کاربری'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ));
                      },
                      child: const Text('ورود'),
                    ),
                  ],
                ),
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
