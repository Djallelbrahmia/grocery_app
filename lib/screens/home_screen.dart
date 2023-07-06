import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/Prodivers/dark_theme_provider.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/widgets/feed_item_widget.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'package:provider/provider.dart';

import '../Prodivers/product_provider.dart';
import '../consts/consts.dart';
import '../models/product_model.dart';
import '../services/utils.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> onSaleProducts = productProvider.getOnsaleProduct;
    List<ProductModel> allProdcuts = productProvider.getProduct;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: utils.screenSize.height * 0.3,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Consts.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                itemCount: 3,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white, activeColor: Colors.red),
                ),
                autoplay: true,
              ),
            ),
            TextButton(
              onPressed: () {
                GlobalMethods.navigateTo(
                    context: context, routName: OnsaleScreen.routeName);
              },
              child: const TextWidget(
                text: "View All",
                color: Colors.blue,
                textsize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'On Sale'.toUpperCase(),
                        color: Colors.red,
                        textsize: 22,
                        isTitle: true,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        IconlyLight.discount,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: SizedBox(
                    height: utils.screenSize.height * 0.24,
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return ChangeNotifierProvider.value(
                            value: onSaleProducts[index],
                            child: const OnSaleWidget());
                      }),
                      itemCount: onSaleProducts.length < 10
                          ? onSaleProducts.length
                          : 10,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    text: "Our Products",
                    color: utils.color,
                    textsize: 20,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        context: context, routName: FeedsScreen.routeName);
                  },
                  child: TextWidget(
                    text: "Browse all",
                    color: Colors.blue,
                    textsize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio:
                    utils.screenSize.width * 1.5 / utils.screenSize.height,
                children: List.generate(
                    allProdcuts.length < 4 ? allProdcuts.length : 4, (index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 2),
                      child: ChangeNotifierProvider.value(
                          value: allProdcuts[index],
                          child: const FeedWidget()));
                }))
          ],
        ),
      ),
    );
  }
}
