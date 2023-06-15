import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  void addProductToCart({
    required String productId,
    required int quantity,
  }) {
    _cartItems.putIfAbsent(
        productId,
        () => CartModel(
            id: const Uuid().v1(), productId: productId, quantity: quantity));
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
          id: value.id, productId: productId, quantity: value.quantity - 1),
    );
    notifyListeners();
  }

  void icreaseQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
          id: value.id, productId: productId, quantity: value.quantity + 1),
    );
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
