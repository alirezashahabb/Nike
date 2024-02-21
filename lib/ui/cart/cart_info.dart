import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/utils.dart';

class CartInfo extends StatelessWidget {
  final int peypablePrice;
  final int shippingCoast;
  final int totlaPrice;
  const CartInfo(
      {super.key,
      required this.peypablePrice,
      required this.shippingCoast,
      required this.totlaPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 8, 8),
          child: Text(
            'جزییات خرید',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1)),
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ قابل پرداخت'),
                    RichText(
                      text: TextSpan(
                        text: peypablePrice.sparedWithComa,
                        style: DefaultTextStyle.of(context).style.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        children: const [
                          TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('هزینه ارسال'),
                    Text(
                      shippingCoast.withPriceLabel,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('جمع نهایی سبد خرید'),
                    RichText(
                      text: TextSpan(
                        text: totlaPrice.sparedWithComa,
                        style: DefaultTextStyle.of(context).style.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 13),
                        children: const [
                          TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
