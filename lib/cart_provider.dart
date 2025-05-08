import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String imageUrl;
  final double price;
  int quantity;

  CartItem({
    required this.title,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });
}

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  int get cartItemCount => _cartItems.length;

  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addItem(CartItem item) {
    final existingIndex = _cartItems.indexWhere((i) => i.title == item.title);
    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _cartItems[index].quantity++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}