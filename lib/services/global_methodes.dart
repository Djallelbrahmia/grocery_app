import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';

import '../widgets/text_wiget.dart';

class GlobalMethods {
  static navigateTo({required BuildContext context, required String routName}) {
    Navigator.of(context).pushNamed(routName);
  }

  static Future<void> WarningDialog(
      {required String title,
      required String subtitle,
      required Function fct,
      required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  "assets/images/warning-sign.png",
                  height: 24,
                  width: 24,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(title)
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                },
                child: const TextWidget(
                  text: "Cancel",
                  color: Colors.cyan,
                  textsize: 20,
                ),
              ),
              TextButton(
                onPressed: () {
                  fct();
                },
                child: const TextWidget(
                  text: "Yes",
                  color: Colors.red,
                  textsize: 20,
                ),
              ),
            ],
            content: Text(subtitle));
      },
    );
  }
}
