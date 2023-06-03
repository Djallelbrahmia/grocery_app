import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.fct,
      required this.buttonText,
      this.primary = Colors.white38});
  final Function fct;
  final String buttonText;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: primary),
        onPressed: () {
          fct();
        },
        child: TextWidget(text: buttonText, color: Colors.white, textsize: 18));
  }
}
