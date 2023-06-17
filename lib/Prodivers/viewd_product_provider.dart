import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/viewd_model.dart';

class ViewdProdProvider with ChangeNotifier {
  Map<String, ViewProductdModel> _viewdProdItems = {};
  Map<String, ViewProductdModel> get getViewdItems {
    return _viewdProdItems;
  }

  void addRemoveProductToViewdList({
    required String productId,
  }) {
    _viewdProdItems.putIfAbsent(productId,
        () => ViewProductdModel(id: const Uuid().v1(), productId: productId));
    notifyListeners();
  }

  void clearHistory() {
    _viewdProdItems.clear();
    notifyListeners();
  }
}
