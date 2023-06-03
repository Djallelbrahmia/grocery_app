import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

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
            const TextWidget(
                text: "Sing in with google", color: Colors.white, textsize: 18),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                SizedBox(
                  width: 5,
                ),
                TextWidget(text: "OR", color: Colors.white, textsize: 18),
                SizedBox(
                  width: 5,
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
