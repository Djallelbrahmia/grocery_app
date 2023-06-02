import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_screen.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

import '../../services/utils.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(
              context: context, routName: ProductScreen.routeName);
        },
        child: Container(
          height: utils.screenSize.height * 0.2,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor.withOpacity(0.5),
            border: Border.all(color: utils.color, width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: utils.screenSize.width * 0.2,
                  height: utils.screenSize.height * 0.25,
                  child: FancyShimmerImage(
                    imageUrl:
                        "https://www.aprifel.com/wp-content/uploads/2019/02/abricot.jpg",
                  )),
              Column(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconlyLight.bag2,
                              color: utils.color,
                            )),
                        HeartButton(),
                      ],
                    ),
                  ),
                  Flexible(
                      child: TextWidget(
                    text: 'Title',
                    color: utils.color,
                    textsize: 20,
                    maxLine: 2,
                    isTitle: true,
                  )),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: "\$9.99",
                    color: Colors.green,
                    textsize: 18,
                    isTitle: true,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
