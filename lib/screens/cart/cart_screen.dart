import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Prodivers/cart_prodiver.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/widgets/empty_cart_screen.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    return cartItemsList.isEmpty
        ? const EmptyCartScreen(
            title: "Your card is empty",
            subtitle: "add something and make me happy",
            buttontext: "Shop now",
            imagePath: 'assets/images/cart.png',
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: "Cart(${cartItemsList.length})",
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
                        subtitle: "Are you sure you wanna empty your card",
                        fct: () {
                          cartProvider.clearCart();
                        },
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: utils.color,
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: utils.screenSize.height * 0.1,
                  child: Row(
                    children: [
                      _checkout(context: context),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: cartItemsList.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: cartItemsList[index],
                          child: CartWidget(
                              quantity: cartItemsList[index].quantity),
                        );
                      }),
                ),
              ],
            ),
          );
  }

  Widget _checkout({required context}) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {},
                  child: const TextWidget(
                      text: "Order now", color: Colors.white, textsize: 20),
                ),
              ),
            ),
            SizedBox(
              width: Utils(context).screenSize.width * 0.3,
            ),
            FittedBox(
              child: TextWidget(
                text: "Total \$18",
                color: Utils(context).color,
                textsize: 20,
                isTitle: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
