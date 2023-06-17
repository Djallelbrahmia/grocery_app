import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Prodivers/wishlist_provider.dart';
import 'package:grocery_app/inner_screens/product_screen.dart';
import 'package:grocery_app/models/wishlist_model.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'package:provider/provider.dart';

import '../../Prodivers/product_provider.dart';
import '../../services/utils.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistModel = Provider.of<WishlistModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productProvider.findById(wishlistModel.productId);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    final Utils utils = Utils(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductScreen.routeName,
              arguments: getCurrentProduct.id);
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
              Flexible(
                flex: 2,
                child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: utils.screenSize.height * 0.25,
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.imageUrl,
                    )),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          HeartButton(
                            productId: getCurrentProduct.id,
                            isWishlist: true,
                          ),
                        ],
                      ),
                    ),
                    TextWidget(
                      text: getCurrentProduct.title,
                      color: utils.color,
                      textsize: 20,
                      maxLine: 2,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: "${usedPrice.toStringAsFixed(2)}\$",
                      color: Colors.green,
                      textsize: 18,
                      isTitle: true,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
