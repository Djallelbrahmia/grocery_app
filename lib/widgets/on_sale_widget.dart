import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Prodivers/cart_prodiver.dart';
import 'package:grocery_app/inner_screens/product_screen.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'package:provider/provider.dart';

import '../Prodivers/wishlist_provider.dart';
import '../consts/firebase_consts.dart';
import '../models/product_model.dart';
import '../services/global_methodes.dart';
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
    final productModel = Provider.of<ProductModel>(context);
    Color color = Utils(context).color;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getwishlistItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductScreen.routeName,
                arguments: productModel.id);
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
                      imageUrl: productModel.imageUrl,
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      boxFit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: productModel.isPiece ? "Piece" : "1Kg",
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
                              onTap: () async {
                                final User? user = authInstance.currentUser;
                                if (user == null) {
                                  GlobalMethods.ErrorDialog(
                                      subtitle:
                                          "No user found ,You must log in first",
                                      context: context);
                                  return;
                                }
                                await GlobalMethods.addTocart(
                                    productId: productModel.id,
                                    quantity: 1,
                                    context: context);
                                await cartProvider.fetchCart();
                              },
                              child: Icon(
                                _isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                size: 24,
                                color: _isInCart ? Colors.green : color,
                              ),
                            ),
                            HeartButton(
                              productId: productModel.id,
                              isWishlist: _isInWishlist,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                PriceWidget(
                  price: productModel.price,
                  salePrice: productModel.salePrice,
                  textPrice: "1",
                  isOnsle: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                    text: productModel.title, color: color, textsize: 16),
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
