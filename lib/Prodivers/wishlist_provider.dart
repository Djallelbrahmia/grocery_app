import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _whishlistItems = {};
  Map<String, WishlistModel> get getwishlistItems {
    return _whishlistItems;
  }

  void addRemoveProductToWishlist({
    required String productId,
  }) {
    if (_whishlistItems.containsKey(productId)) {
      removeOneItem(productId);
    } else {
      _whishlistItems.putIfAbsent(productId,
          () => WishlistModel(id: const Uuid().v1(), productId: productId));
    }
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _whishlistItems.remove(productId);
    notifyListeners();
  }

  void clearWishlist() {
    _whishlistItems.clear();
    notifyListeners();
  }
}
