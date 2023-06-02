import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/quantity_controller_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

class ViewedWidget extends StatelessWidget {
  const ViewedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: FancyShimmerImage(
          width: utils.screenSize.width * 0.25,
          height: utils.screenSize.width * 0.3,
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
      trailing: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                CupertinoIcons.plus,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
