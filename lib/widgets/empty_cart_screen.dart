import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttontext,
  });
  final String imagePath, title, subtitle, buttontext;
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                imagePath,
                width: double.infinity,
                height: utils.screenSize.height * 0.4,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Woops!",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: title,
                color: Color.fromARGB(255, 4, 133, 108),
                textsize: 28,
                isTitle: true,
              ),
              const SizedBox(
                height: 15,
              ),
              TextWidget(text: subtitle, color: Colors.cyan, textsize: 20),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: utils.color),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      foregroundColor: utils.color,
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        context: context, routName: FeedsScreen.routeName);
                  },
                  child: TextWidget(
                    isTitle: true,
                    text: buttontext,
                    textsize: 20,
                    color: utils.getTheme
                        ? Colors.grey.shade300
                        : Colors.grey.shade500,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
