import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';

class GlobalMethods {
  static navigateTo({required BuildContext context, required String routName}) {
    Navigator.of(context).pushNamed(routName);
  }
}
