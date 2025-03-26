import 'package:handmade_app/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/user.dart';
import '../../utility/constants.dart';
import '../../widget/app_bar_action_button.dart';
import '../../widget/custom_search_bar.dart';
import '../product_cart_screen/cart_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomSearchBar(
                  controller: TextEditingController(),
                  onChanged: (val) {
                    context.dataProvider.filterProducts(val);
                  },
                ),
              ),
            ),
            AppBarActionButton(
              icon: Icons.notifications,
              onPressed: () {

              },
            ),
            AppBarActionButton(
              icon: Icons.shopping_cart,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CartScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}