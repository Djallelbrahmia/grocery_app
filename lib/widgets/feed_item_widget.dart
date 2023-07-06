import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/Prodivers/cart_prodiver.dart';
import 'package:grocery_app/inner_screens/product_screen.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'package:provider/provider.dart';

import '../Prodivers/wishlist_provider.dart';
import '../consts/firebase_consts.dart';
import '../services/global_methodes.dart';
import '../services/utils.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({super.key});

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    _quantityController.text = "1";
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    Color color = Utils(context).color;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getwishlistItems.containsKey(productModel.id);

    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            // Navigator.of(context).pushNamed(ProductScreen.routeName);
            Navigator.pushNamed(context, ProductScreen.routeName,
                arguments: productModel.id);
          },
          borderRadius: BorderRadius.circular(8),
          child: Column(children: [
            FancyShimmerImage(
              imageUrl: productModel.imageUrl,
              height: size.width * 0.2,
              width: double.infinity,
              boxFit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: TextWidget(
                      maxLine: 1,
                      text: productModel.title,
                      color: color,
                      textsize: 20,
                      isTitle: true,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: HeartButton(
                        productId: productModel.id,
                        isWishlist: _isInWishlist,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: PriceWidget(
                      price: productModel.price,
                      salePrice: productModel.salePrice,
                      textPrice: _quantityController.text,
                      isOnsle: productModel.isOnSale,
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: Row(
                      children: [
                        FittedBox(
                          child: TextWidget(
                            text: productModel.isPiece ? "Piece" : "KG",
                            color: color,
                            textsize: 16,
                            isTitle: true,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                            flex: 2,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    _quantityController.text = '0';
                                  }
                                });
                              },
                              controller: _quantityController,
                              key: const ValueKey(5),
                              style: TextStyle(color: color, fontSize: 18),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              enabled: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'),
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () async {
                final User? user = authInstance.currentUser;
                if (user == null) {
                  GlobalMethods.ErrorDialog(
                      subtitle: "No user found ,You must log in first",
                      context: context);
                  return;
                }
                _isInCart
                    ? null
                    : await GlobalMethods.addTocart(
                        productId: productModel.id,
                        quantity: int.parse(_quantityController.text),
                        context: context);
                await cartProvider.fetchCart();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).canvasColor),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: TextWidget(
                  text: _isInCart ? 'In cart' : 'Add to cart',
                  maxLine: 1,
                  color: color,
                  textsize: 20,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
