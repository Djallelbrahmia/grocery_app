import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  final userCollection = FirebaseFirestore.instance.collection("users");

  Future<void> fetchCart() async {
    final User? user = authInstance.currentUser;

    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    if (userDoc == null) {
      return;
    }
    final length = userDoc.get("UserCart").length;
    for (int i = 0; i < length; i++) {
      _cartItems.putIfAbsent(
          userDoc.get('UserCart')[i]['productId'],
          () => CartModel(
                id: userDoc.get('UserCart')[i]['cartId'],
                productId: userDoc.get('UserCart')[i]['productId'],
                quantity: userDoc.get('UserCart')[i]['quantity'],
              ));
    }
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

  Future<void> removeOneItem(
      {required String productId,
      required int quantity,
      required String cartId}) async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({
      'UserCart': FieldValue.arrayRemove([
        {
          'cartId': cartId,
          'productId': productId,
          'quantity': quantity,
        }
      ])
    });
    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  Future<void> clearOnlinecart() async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({'UserCart': []});
    _cartItems.clear();
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
