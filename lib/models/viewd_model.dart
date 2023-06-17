import 'package:flutter/material.dart';

class ViewProductdModel with ChangeNotifier {
  final String id, productId;

  ViewProductdModel({
    required this.id,
    required this.productId,
  });
}
