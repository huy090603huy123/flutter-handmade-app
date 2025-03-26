import 'package:handmade_app/utility/extensions.dart';

import '../../../utility/utility_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';


class CartListSection extends StatelessWidget {
  final List<CartModel> cartProducts;

  const CartListSection({
    super.key,
    required this.cartProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: cartProducts.mapWithIndex((index, _) {
            CartModel cartItem = cartProducts[index];
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15), // Thêm padding
              decoration: BoxDecoration(
                color: Colors.white, // Màu nền trắng
                borderRadius: BorderRadius.circular(10),
                boxShadow: [ // Thêm đổ bóng
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.start, // Căn chỉnh từ trên xuống
                alignment: WrapAlignment.spaceBetween, // Giãn cách đều ra hai đầu
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.primaries[index].withOpacity(0.2), // Màu nền nhạt hơn
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.network(
                          cartItem.productImages.safeElementAt(0) ?? '',
                          width: 80, // Chỉnh kích thước ảnh
                          height: 80,
                          fit: BoxFit.cover, // Bo tròn góc ảnh
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null, // Progress indicator.
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return const Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16, // Tăng kích thước chữ
                        ),
                      ),
                      const SizedBox(height: 8), // Tăng khoảng cách
                      Text(
                        'Số lượng: ${cartItem.quantity}', // Thêm chữ "Số lượng:"
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8), // Tăng khoảng cách
                      Text(
                        "${cartItem.variants.safeElementAt(0)?.price.toStringAsFixed(0)}đ",
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20, // Tăng kích thước giá
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8), // Thêm khoảng cách
                      Text(
                        "Tổng: ${(cartItem.variants.safeElementAt(0)!.price * cartItem.quantity).toStringAsFixed(0)}đ", // Thêm tổng tiền
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  // Add and remove cart item
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, // Màu nền nút
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          splashRadius: 10.0,
                          onPressed: () {

                            context.cartProvider.updateCart(cartItem, -1);
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.red, // Màu đỏ
                          ),
                        ),
                        Text(
                          '${cartItem.quantity}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          splashRadius: 10.0,
                          onPressed: () {
                            //TODO: should complete updateCart increment
                            context.cartProvider.updateCart(cartItem, 1);
                          },
                          icon: const Icon(Icons.add, color: Colors.green), // Màu xanh
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}