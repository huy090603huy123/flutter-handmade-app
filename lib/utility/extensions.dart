import '../screen/login_screen/user_provider.dart';
import '../screen/product_cart_screen/cart_provider.dart';
import '../screen/profile_screen/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../core/data_provider.dart';
import '../screen/product_by_category_screen/product_by_category_provider.dart';
import '../screen/product_details_screen/product_detail_provider.dart';
import '../screen/product_favorite_screen/favorite_provider.dart';

extension Providers on BuildContext {
  DataProvider get dataProvider => Provider.of<DataProvider>(this, listen: false);
  ProductByCategoryProvider get proByCProvider => Provider.of<ProductByCategoryProvider>(this, listen: false);
  ProductDetailProvider get proDetailProvider => Provider.of<ProductDetailProvider>(this, listen: false);
  CartProvider get cartProvider => Provider.of<CartProvider>(this, listen: false);
  FavoriteProvider get favoriteProvider => Provider.of<FavoriteProvider>(this, listen: false);
  UserProvider get userProvider => Provider.of<UserProvider>(this, listen: false);
  ProfileProvider get profileProvider => Provider.of<ProfileProvider>(this, listen: false);
}






