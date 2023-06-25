import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/models/viewd_model.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'package:provider/provider.dart';

import '../../Prodivers/cart_prodiver.dart';
import '../../Prodivers/product_provider.dart';
import '../../consts/firebase_consts.dart';
import '../../inner_screens/product_screen.dart';

class ViewedWidget extends StatelessWidget {
  const ViewedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewdProdModel = Provider.of<ViewProductdModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct =
        productProvider.findById(viewdProdModel.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.id);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    final Utils utils = Utils(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductScreen.routeName,
            arguments: getCurrentProduct.id);
      },
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.antiAlias,
          child: FancyShimmerImage(
            width: utils.screenSize.width * 0.25,
            height: utils.screenSize.width * 0.3,
            boxFit: BoxFit.fill,
            boxDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12)),
            imageUrl: getCurrentProduct.imageUrl,
          ),
        ),
        title: TextWidget(
          text: getCurrentProduct.title,
          color: utils.color,
          textsize: 18,
          isTitle: true,
        ),
        subtitle: TextWidget(
          text: "${usedPrice.toStringAsFixed(2)}\$",
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
              onTap: () {
                final User? user = authInstance.currentUser;
                if (user == null) {
                  GlobalMethods.ErrorDialog(
                      subtitle: "No user found ,You must log in first",
                      context: context);
                  return;
                }
                _isInCart
                    ? null
                    : cartProvider.addProductToCart(
                        productId: getCurrentProduct.id, quantity: 1);
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Icon(
                  _isInCart ? Icons.check : IconlyBold.plus,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
