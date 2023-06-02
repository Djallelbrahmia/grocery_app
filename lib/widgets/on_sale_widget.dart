import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_screen.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

import '../services/utils.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    final them = Utils(context).getTheme;
    Color color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).pushNamed(ProductScreen.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FancyShimmerImage(
                      imageUrl:
                          "https://www.aprifel.com/wp-content/uploads/2019/02/abricot.jpg",
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      boxFit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: "1Kg",
                          color: color,
                          textsize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.bag2,
                                size: 24,
                                color: color,
                              ),
                            ),
                            HeartButton(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const PriceWidget(
                  price: 2,
                  salePrice: 1.5,
                  textPrice: "1",
                  isOnsle: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(text: "Product title", color: color, textsize: 16),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}