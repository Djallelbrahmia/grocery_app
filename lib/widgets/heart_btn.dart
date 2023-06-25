import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Prodivers/wishlist_provider.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartButton extends StatelessWidget {
  const HeartButton(
      {super.key, required this.productId, this.isWishlist = false});
  final String productId;
  final bool? isWishlist;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return GestureDetector(
      onTap: () {
        final User? user = authInstance.currentUser;
        if (user == null) {
          GlobalMethods.ErrorDialog(
              subtitle: "No user found ,You must log in first",
              context: context);
          return;
        }
        wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
        isWishlist != null && isWishlist == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 24,
        color: isWishlist != null && isWishlist == true ? Colors.red : color,
      ),
    );
  }
}
