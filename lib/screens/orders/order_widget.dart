import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: FancyShimmerImage(
          width: utils.screenSize.width * 0.2,
          boxFit: BoxFit.fill,
          boxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          imageUrl:
              "https://www.aprifel.com/wp-content/uploads/2019/02/abricot.jpg",
        ),
      ),
      title: TextWidget(
        text: "Title",
        color: utils.color,
        textsize: 18,
        isTitle: true,
      ),
      subtitle: TextWidget(
        text: "subtitle",
        color: utils.color,
        textsize: 18,
        isTitle: false,
      ),
      trailing:
          TextWidget(text: "18/06/2023", color: utils.color, textsize: 18),
    );
  }
}
