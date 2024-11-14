import 'package:nikkle/models/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  Future<void> saveCartItems(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson =
        cartItems.map((item) => item.toJson()).toList();
    await prefs.setStringList('cartItems', cartItemsJson);
  }

  Future<List<CartItem>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsJson = prefs.getStringList('cartItems');

    if (cartItemsJson == null) {
      return [];
    } else {
      return cartItemsJson
          .map((itemJson) => CartItem.fromJson(itemJson))
          .toList();
    }
  }
}
