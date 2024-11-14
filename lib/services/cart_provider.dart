import 'package:flutter/material.dart';
import 'package:nikkle/models/cart_item.dart';
import 'package:nikkle/services/cart_service.dart';

class CartProvider with ChangeNotifier {
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];

  ValueNotifier<int> itemCount = ValueNotifier<int>(0);
  ValueNotifier<double> totalAmount = ValueNotifier<double>(0.0);

  List<CartItem> get cartItems => _cartItems;

  Future<void> loadCart() async {
    _cartItems = await _cartService.loadCartItems();
    itemCount.value = _calculateTotalQuantity();
    totalAmount.value = _calculateTotalAmount();
    notifyListeners();
  }

  Future<void> addItemToCart(CartItem item) async {
    _cartItems.add(item);
    itemCount.value += item.selectedqty;
    totalAmount.value = _calculateTotalAmount();
    await _cartService.saveCartItems(_cartItems);
    notifyListeners();
  }

  Future<void> removeItemFromCart(CartItem item) async {
    _cartItems.remove(item);
    itemCount.value -= item.selectedqty;
    totalAmount.value = _calculateTotalAmount();
    await _cartService.saveCartItems(_cartItems);
    notifyListeners();
  }

  Future<void> clearCart() async {
    _cartItems.clear();
    itemCount.value = 0;
    totalAmount.value = 0.0;
    await _cartService.saveCartItems(_cartItems);
    notifyListeners();
  }

  int _calculateTotalQuantity() {
    return _cartItems.fold(0, (sum, item) => sum + item.selectedqty);
  }

  double _calculateTotalAmount() {
    return _cartItems.fold(
        0.0, (sum, item) => sum + (item.price * item.selectedqty));
  }

  void increaseQuantity(CartItem item) {
    item.selectedqty++;
    itemCount.value++;
    totalAmount.value = _calculateTotalAmount();
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.selectedqty > 1) {
      item.selectedqty--;
      itemCount.value--;
      totalAmount.value = _calculateTotalAmount();
      notifyListeners();
    }
  }
}
