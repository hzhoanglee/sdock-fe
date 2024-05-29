import 'package:sdock_fe/full_apps/animations/shopping/models/cart.dart';
import 'package:sdock_fe/full_apps/animations/shopping/models/category.dart';
import 'package:sdock_fe/full_apps/animations/shopping/models/product.dart';

class ShoppingCache {
  static List<Category>? categories;
  static List<Product>? products;
  static List<Cart>? carts;

  static bool isFirstTime = true;
}
