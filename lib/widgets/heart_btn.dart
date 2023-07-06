import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Prodivers/product_provider.dart';
import 'package:grocery_app/Prodivers/wishlist_provider.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartButton extends StatefulWidget {
  const HeartButton(
      {super.key, required this.productId, this.isWishlist = false});
  final String productId;
  final bool? isWishlist;

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productProvider.findById(widget.productId);
    Color color = Utils(context).color;

    return GestureDetector(
      onTap: () async {
        setState(() {
          loading = true;
        });
        try {
          final User? user = authInstance.currentUser;
          if (user == null) {
            GlobalMethods.ErrorDialog(
                subtitle: "No user found ,You must log in first",
                context: context);
            return;
          }
          (widget.isWishlist == false && widget.isWishlist != null)
              ? await GlobalMethods.addtoWishlist(
                  productId: widget.productId, context: context)
              : await wishListProvider.removeOneItem(
                  productId: widget.productId,
                  wishListId: wishListProvider
                      .getWishListItems[getCurrentProduct.id]!.id);
          await wishListProvider.fetchwish();
          setState(() {
            loading = false;
          });
        } catch (e) {
          GlobalMethods.ErrorDialog(subtitle: e.toString(), context: context);
          setState(() {
            loading = false;
          });
        } finally {
          setState(() {
            loading = false;
          });
        }
      },
      child: loading
          ? const Padding(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              ),
            )
          : Icon(
              widget.isWishlist != null && widget.isWishlist == true
                  ? IconlyBold.heart
                  : IconlyLight.heart,
              size: 24,
              color: widget.isWishlist != null && widget.isWishlist == true
                  ? Colors.red
                  : color,
            ),
    );
  }
}
