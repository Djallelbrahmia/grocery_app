import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/categories_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  final List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

  final List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/cat/fruits.png',
      'catText': 'Fruits',
    },
    {
      'imgPath': 'assets/images/cat/veg.png',
      'catText': 'Vegetables',
    },
    {
      'imgPath': 'assets/images/cat/Spinach.png',
      'catText': 'Herbs',
    },
    {
      'imgPath': 'assets/images/cat/nuts.png',
      'catText': 'Nuts',
    },
    {
      'imgPath': 'assets/images/cat/spices.png',
      'catText': 'Spices',
    },
    {
      'imgPath': 'assets/images/cat/grains.png',
      'catText': 'Grains',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: TextWidget(
          text: "Categories",
          textsize: 24,
          isTitle: true,
          color: color,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 8),
        child: GridView.count(
          crossAxisSpacing: 24,
          crossAxisCount: 2,
          childAspectRatio: 280 / 259,
          mainAxisSpacing: 24,
          children: List.generate(
              6,
              (index) => CategoriesWidget(
                    catText: catInfo[index]["catText"],
                    imgPath: catInfo[index]["imgPath"],
                    passedColor: gridColors[index],
                  )),
        ),
      ),
    );
  }
}
