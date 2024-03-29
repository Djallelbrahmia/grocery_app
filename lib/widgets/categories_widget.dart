import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/cat_screen.dart';
import 'package:grocery_app/Prodivers/dark_theme_provider.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {super.key,
      required this.catText,
      required this.imgPath,
      required this.passedColor});
  final String catText, imgPath;
  final Color passedColor;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DarkThemeProvider>(context);
    final bool themeData = provider.getDarkTheme;
    final Color color = themeData ? Colors.white : Colors.black;
    double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CategoryFeedsScreen.routeName,
            arguments: catText);
      },
      child: Container(
        decoration: BoxDecoration(
          color: passedColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: passedColor.withOpacity(0.7),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: _screenWidth * 0.3,
              width: _screenWidth * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      imgPath,
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            TextWidget(
              text: catText,
              color: color,
              textsize: 20,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
