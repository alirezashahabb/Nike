import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/utils.dart';
import 'package:flutter_application_1/data/cart_list.dart';
import 'package:flutter_application_1/ui/widgets/image.dart';

/// this is for cart item in cart
class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.items,
    required this.themeData,
    required this.deletedButton,
    required this.increamentButton,
    required this.deacrementButton,
  });

  final CartItemEntity items;
  final ThemeData themeData;
  final GestureTapCallback deletedButton;
  final GestureTapCallback increamentButton;
  final GestureTapCallback deacrementButton;

  @override
  Widget build(BuildContext context) {
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
                    Text('تعداد', style: themeData.textTheme.bodySmall),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: increamentButton,
                          child: Container(
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
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        items.changeCountLoading
                            ? const SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                items.count.toString(),
                              ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: deacrementButton,
                          child: Container(
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
                          .copyWith(decoration: TextDecoration.lineThrough),
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

          /// this is for delete button
          items.deletedButtonLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                )
              : TextButton(
                  onPressed: deletedButton,
                  child: const Text('حذف از سبد خرید'))
        ],
      ),
    );
  }
}
