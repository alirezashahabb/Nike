import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/utils.dart';
import 'package:flutter_application_1/data/repo/auth_repository.dart';
import 'package:flutter_application_1/ui/auth/auth.dart';
import 'package:flutter_application_1/ui/cart/bloc/cart_bloc.dart';
import 'package:flutter_application_1/ui/home/home.dart';
import 'package:flutter_application_1/ui/widgets/emptry_view.dart';
import 'package:flutter_application_1/ui/widgets/image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../data/repo/cart_repositroy.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
  StreamSubscription? streamSubscription;
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
    streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController = RefreshController();
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: BlocProvider(
        create: (context) {
          var bloc = CartBloc(cartRepository);
          ////////////////////////////////////////////////////////////Stream
          streamSubscription = bloc.stream.listen((state) {
            if (refreshController.isRefresh) {
              if (state is CartSuccessState) {
                refreshController.refreshCompleted();
              } else if (state is CartErrorState) {
                refreshController.refreshFailed();
              }
            }
          });
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
              return SmartRefresher(
                header: const ClassicHeader(
                  completeText: 'با موفقیت انجام شد',
                  refreshingText: 'در حال انجام...',
                  idleText: 'برای بارگذاری دکمه را فشار دهید',
                  releaseText: 'برای بارگذاری دکمه را رها کنید',
                  failedText: 'خطا رخ داده است',
                ),
                controller: refreshController,
                onRefresh: () {
                  cartBloc?.add(
                    CartInitEvent(
                        authInfo: AuthRepository.authChangeNotifier.value,
                        isRefresh: true),
                  );
                },
                child: ListView.builder(
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
                                      items
                                          .product.previousPrice.withPriceLabel,
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
                ),
              );
            } else if (state is CartAuthRequairedState) {
              return EmptyView(
                title: 'لطفا وارد حساب کاربری خود شوید',
                callBack: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ));
                  },
                  child: const Text('ورود'),
                ),
                image: Lottie.asset('assets/img/cart_login.json'),
              );
            } else if (state is CartEmptyState) {
              return EmptyView(
                title: 'سبد خرید خالی است',
                callBack: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text('مشاهده محصولات'),
                ),
                image: Lottie.asset('assets/img/cart_empty.json'),
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
