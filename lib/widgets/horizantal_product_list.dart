import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/image_loading_service.dart';
import 'package:flutter_application_1/common/utils.dart';
import 'package:flutter_application_1/data/module/product_module.dart';
import 'package:flutter_application_1/screen/product_detail_screen.dart';

/// this class for ProductList horizontal
class HorizontalLIstView extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;
  const HorizontalLIstView({
    super.key,
    required this.products,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(onPressed: onTap, child: const Text('مشاهده همه'))
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 8, right: 8),
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItems(product: product);
            },
          ),
        )
      ],
    );
  }
}

/// ========================================>>>>>>>>this class for Product Items
class ProductItems extends StatelessWidget {
  const ProductItems({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProductDetailScreen(),
            ),
          );
        },
        child: SizedBox(
          width: 176,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 189,
                    width: 176,
                    child: ImageLoadingService(
                      imageUrl: product.image,
                      radius: 12,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      alignment: Alignment.center,
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        CupertinoIcons.heart,
                        size: 24,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(product.previousPrice.withPriceLabe,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        decoration: TextDecoration.lineThrough,
                      )),
              const SizedBox(
                height: 4,
              ),
              Text(
                product.price.withPriceLabe,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
