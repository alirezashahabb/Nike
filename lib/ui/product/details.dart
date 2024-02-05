import 'dart:async';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/utils.dart';
import 'package:flutter_application_1/data/product.dart';
import 'package:flutter_application_1/data/repo/cart_repositroy.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_application_1/ui/cart/bloc/cart_bloc.dart';
import 'package:flutter_application_1/ui/product/comment/comment_list.dart';
import 'package:flutter_application_1/ui/widgets/image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  /// when page is Close and State finish ====> 43 minute
  StreamSubscription<CartState>? streamSubscription;
  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) {
          var bloc = CartBloc(cartRepository);

          streamSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              CherryToast.success(
                      title: const Text(
                        '',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      description: const Text(
                        'محصول با موفقیت به سبد خرید شما اضافه شد',
                      ),
                      displayTitle: false,
                      animationDuration: const Duration(milliseconds: 1000),
                      autoDismiss: true)
                  .show(context);
            } else if (state is ProductAddToCartError) {
              CherryToast.error(
                      title: Text(
                        state.exception.message,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      displayTitle: false,
                      animationDuration: const Duration(milliseconds: 1000),
                      autoDismiss: true)
                  .show(context);
            }
          });
          return bloc;
        },
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width - 48,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return FloatingActionButton.extended(
                  backgroundColor: LightThemeColors.secondaryColor,
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context).add(
                      CartAddToBasketEvent(productId: widget.product.id),
                    );
                  },
                  label: state is ProductAddToCatLoadingState
                      ? const CupertinoActivityIndicator()
                      : const Text('افزودن به سبد خرید'),
                );
              },
            ),
          ),
          body: CustomScrollView(
            physics: defaultScrollPhysics,
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width * 0.8,
                flexibleSpace:
                    ImageLoadingService(imageUrl: widget.product.imageUrl),
                foregroundColor: LightThemeColors.primaryTextColor,
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            widget.product.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.product.previousPrice.withPriceLabel,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(
                                        decoration: TextDecoration.lineThrough),
                              ),
                              Text(widget.product.price.withPriceLabel),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود',
                        style: TextStyle(height: 1.4),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'نظرات کاربران',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text('ثبت نظر'))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CommentList(productId: widget.product.id),
            ],
          ),
        ),
      ),
    );
  }
}
