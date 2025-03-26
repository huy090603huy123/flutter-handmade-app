import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../screen/product_favorite_screen/favorite_provider.dart';
import '../utility/extensions.dart';
import '../utility/utility_extention.dart';
import 'custom_network_image.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;
  final int index;
  final bool isPriceOff;

  const ProductGridTile({
    super.key,
    required this.product,
    required this.index,
    required this.isPriceOff,
  });

  @override
  Widget build(BuildContext context) {
    double discountPercentage = context.dataProvider
        .calculateDiscountPercentage(product.price ?? 0, product.offerPrice ?? 0);
    return GridTile(
      header: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: discountPercentage != 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.red,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  "-${discountPercentage.toInt()}%",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Consumer<FavoriteProvider>(
              builder: (context, favoriteProvider, child) {
                return IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: favoriteProvider.checkIsItemFavorite(product.sId ?? '')
                        ? Colors.red
                        : const Color(0xFFA6A3A0),
                  ),
                  onPressed: () {
                    context.favoriteProvider
                        .updateToFavoriteList(product.sId ?? '');
                  },
                );
              },
            ),
          ],
        ),
      ),
      footer: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Canh lề cho Row
              children: [
                Row( // Row cho giá tiền
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product.offerPrice != 0
                          ? "${product.offerPrice?.toStringAsFixed(0)}"
                          : "${product.price?.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const Text(
                      " đ",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (product.offerPrice != null &&
                        product.offerPrice != product.price)
                      Text(
                        "${product.price?.toStringAsFixed(0)} đ",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Row( // Row cho đã bán
              children: [
                const SizedBox(width: 3),
                Text(
                  "Đã bán ${product.quantity ?? 0}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 16,
                ),
                const SizedBox(width: 3),
                const Text(
                  "4.5",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  size: 16,
                ),
                const SizedBox(width: 3),
                const Text(
                  "TP.HCM",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CustomNetworkImage(
          imageUrl: product.images!.isNotEmpty
              ? product.images?.safeElementAt(0)?.url ?? ''
              : '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}