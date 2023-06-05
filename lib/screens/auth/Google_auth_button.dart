import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, this.buttonText = "Sign in with google"});
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                color: Colors.white,
                child: Image.asset(width: 40, 'assets/images/google.png')),
            const SizedBox(width: 8),
            TextWidget(text: buttonText, color: Colors.white, textsize: 18),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
