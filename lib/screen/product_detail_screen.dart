import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/image_loading_service.dart';
import 'package:flutter_application_1/common/utils.dart';
import 'package:flutter_application_1/data/module/product_module.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity products;
  const ProductDetailScreen({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('افزودن به سبد خرید'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageLoadingService(imageUrl: products.image),
              actions: const [
                Icon(CupertinoIcons.heart),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  /// for title and price and previousPrice
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            products.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20),
                          ),
                        ),
                        Column(
                          children: [
                            Text(products.previousPrice.withPriceLabe,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    )),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              products.price.withPriceLabe,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Text(
                        'یک دویدن کوتاه می تواند کل حال و هوای روزتان را عوض کند و به شما برای ادامه آن انرژی بدهد. همه چیز بهتر می شود وقتی که می بینید چقدر دویدن برایتان آسان شده است. این دقیقا کاری است که آدیداس پیور بوست 23 برای شما انجام می دهد؛ یعنی ایجاد حس موفقیت!'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('نظر کاربران',
                            style: Theme.of(context).textTheme.titleMedium),
                        TextButton(
                            onPressed: () {}, child: const Text('ثبت نظر'))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
