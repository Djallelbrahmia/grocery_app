import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/screens/wishlist/wishlist_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

import '../../services/global_methodes.dart';
import '../../services/utils.dart';
import '../../widgets/empty_cart_screen.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});
  static const String routeName = "wishlistScreen";
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    bool _isEmpty = true;

    return _isEmpty
        ? const EmptyCartScreen(
            title: "Your wishlist is empty",
            subtitle: "Explore more items",
            buttontext: "Make a wish !",
            imagePath: 'assets/images/wishlist.png',
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  IconlyLight.arrowLeft2,
                  color: utils.color,
                  size: 24,
                ),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: "Wishlist",
                  color: utils.color,
                  textsize: 22,
                  isTitle: true,
                ),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.WarningDialog(
                        title: "Delete",
                        subtitle: "Are you sure you wanna empty your wishlist ",
                        fct: () {},
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: utils.color,
                  ),
                )
              ],
            ),
            body: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return const WishlistWidget();
              },
            ));
  }
}
