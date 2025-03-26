import 'package:handmade_app/utility/extensions.dart';

import 'product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/carousel_slider.dart';
import '../../../../widget/page_wrapper.dart';
import '../../models/product.dart';
import '../../widget/horizondal_list.dart';
import 'product_rating_section.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: PageWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //? product image section
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5), // Lighter background color
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200),
                      bottomLeft: Radius.circular(200),
                    ),
                  ),
                  child: CarouselSlider(items: product.images ?? []),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //? product name
                      Text(
                        '${product.name}',
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ), // Bold product name
                      ),
                      const SizedBox(height: 10),
                      //? product rating section
                      const ProductRatingSection(),
                      const SizedBox(height: 10),
                      //? product rate , offer , stock section
                      Row(
                        children: [
                          Text(
                            product.offerPrice != null
                                ? "${product.offerPrice?.toStringAsFixed(0)}đ"
                                : "${product.price?.toStringAsFixed(0)}đ",
                            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: Colors.redAccent, // Highlight the price
                            ),
                          ),
                          const SizedBox(width: 3),
                          Visibility(
                            visible: product.offerPrice != product.price,
                            child: Text(
                              "${product.price?.toStringAsFixed(0)}đ",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            product.quantity != 0
                                ? "Số lượng : ${product.quantity}"
                                : "Không có sẵn",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      product.proVariantId!.isNotEmpty
                          ? Text(
                        ' ${product.proVariantTypeId?.type} sẵn có ',
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 16), // Changed color
                      )
                          : const SizedBox(),
                      Consumer<ProductDetailProvider>(
                        builder: (context, proDetailProvider, child) {
                          return HorizontalList(
                            items: product.proVariantId ?? [],
                            itemToString: (val) => val,
                            selected: proDetailProvider.selectedVariant,
                            onSelect: (val) {
                              proDetailProvider.selectedVariant = val;
                              proDetailProvider.updateUI();
                            },
                          );
                        },
                      ),
                      //? product description
                      Text(
                        "Mô tả",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text("${product.description}"),
                      const SizedBox(height: 40),
                      Text(
                        "Thương Hiệu",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text("${product.proBrandId?.name}"),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent, // Changed button color
                          ),
                          onPressed: product.quantity != 0
                              ? () {
                            //TODO: should complete call addToCart
                            context.proDetailProvider.addToCart(product);
                          }
                              : null,
                          child: const Text("Thêm vào giỏ hàng",
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}