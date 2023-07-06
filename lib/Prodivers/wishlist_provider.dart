import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../consts/firebase_consts.dart';
import '../models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _whishlistItems = {};
  Map<String, WishlistModel> get getwishlistItems {
    return _whishlistItems;
  }

  Map<String, WishlistModel> get getWishListItems {
    return _whishlistItems;
  }

  final userCollection = FirebaseFirestore.instance.collection("users");

  Future<void> fetchwish() async {
    final User? user = authInstance.currentUser;

    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    if (userDoc == null) {
      return;
    }
    final length = userDoc.get("userWish").length;
    for (int i = 0; i < length; i++) {
      _whishlistItems.putIfAbsent(
          userDoc.get('userWish')[i]['productId'],
          () => WishlistModel(
                id: userDoc.get('userWish')[i]['wishlistid'],
                productId: userDoc.get('userWish')[i]['productId'],
              ));
    }
    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String productId, required String wishListId}) async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({
      'userWish': FieldValue.arrayRemove([
        {
          'wishlistid': wishListId,
          'productId': productId,
        }
      ])
    });
    _whishlistItems.remove(productId);
    await fetchwish();
    notifyListeners();
  }

  Future<void> clearOnlinewishlist() async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({'userWish': []});
    _whishlistItems.clear();
    notifyListeners();
  }

  void clearLocalWishlist() {
    _whishlistItems.clear();
    notifyListeners();
  }
}
