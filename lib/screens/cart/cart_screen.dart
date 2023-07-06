import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/Prodivers/cart_prodiver.dart';
import 'package:grocery_app/Prodivers/orders_provider.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/widgets/empty_cart_screen.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../Prodivers/product_provider.dart';
import '../../consts/firebase_consts.dart';
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
              automaticallyImplyLeading: false,
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
                        fct: () async {
                          cartProvider.clearLocalCart();

                          await cartProvider.clearOnlinecart();
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
    final cartProvider = Provider.of<CartProvider>(context);
    double total = 0.0;
    final productProvider = Provider.of<ProductProvider>(context);
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrentProduct = productProvider.findById(value.productId);
      total += (getCurrentProduct.isOnSale
              ? getCurrentProduct.salePrice
              : getCurrentProduct.price) *
          value.quantity;
    });
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
                  onTap: () async {
                    User? user = authInstance.currentUser;
                    final productProvider =
                        Provider.of<ProductProvider>(context, listen: false);
                    final ordersProvider =
                        Provider.of<OrderProvider>(context, listen: false);
                    cartProvider.getCartItems.forEach((key, value) async {
                      final orderId = const Uuid().v1();

                      final getCurrProduct = productProvider.findById(
                        value.productId,
                      );
                      try {
                        await FirebaseFirestore.instance
                            .collection('orders')
                            .doc(orderId)
                            .set({
                          'orderId': orderId,
                          'userId': user!.uid,
                          'productId': value.productId,
                          'price': (getCurrProduct.isOnSale
                                  ? getCurrProduct.salePrice
                                  : getCurrProduct.price) *
                              value.quantity,
                          'totalPrice': total,
                          'quantity': value.quantity,
                          'imageUrl': getCurrProduct.imageUrl,
                          'userName': user.displayName,
                          'orderDate': Timestamp.now(),
                        });
                      } catch (e) {
                        GlobalMethods.ErrorDialog(
                            subtitle: e.toString(), context: context);
                      } finally {}
                    });
                    await ordersProvider.fetchOrders();
                    await cartProvider.clearOnlinecart();
                    cartProvider.clearLocalCart();
                    await Fluttertoast.showToast(
                        msg: "Your order has been placed ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER);
                  },
                  child: const TextWidget(
                      text: "Order now", color: Colors.white, textsize: 20),
                ),
              ),
            ),
            SizedBox(
              width: Utils(context).screenSize.width * 0.2,
            ),
            FittedBox(
              child: TextWidget(
                text: " Total : \$${total.toStringAsFixed(2)}",
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
