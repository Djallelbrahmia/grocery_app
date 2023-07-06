import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/Prodivers/wishlist_provider.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../widgets/text_wiget.dart';

class GlobalMethods {
  static navigateTo({required BuildContext context, required String routName}) {
    Navigator.of(context).pushNamed(routName);
  }

  static Future<void> WarningDialog(
      {required String title,
      required String subtitle,
      required Function fct,
      required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                "assets/images/warning-sign.png",
                height: 24,
                width: 24,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(title)
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              child: const TextWidget(
                text: "Cancel",
                color: Colors.cyan,
                textsize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                fct();
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              child: const TextWidget(
                text: "Yes",
                color: Colors.red,
                textsize: 20,
              ),
            ),
          ],
          content: Text(subtitle),
        );
      },
    );
  }

  static Future<void> ErrorDialog(
      {required String subtitle, required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                "assets/images/warning-sign.png",
                height: 24,
                width: 24,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 16,
              ),
              const Text("An Error Occured")
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              child: const TextWidget(
                text: "Ok",
                color: Colors.cyan,
                textsize: 20,
              ),
            ),
          ],
          content: Text(subtitle),
        );
      },
    );
  }

  static Future<void> addTocart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final cartId = Uuid().v1();
    try {
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'UserCart': FieldValue.arrayUnion([
          {'cartId': cartId, 'productId': productId, 'quantity': quantity}
        ])
      });
      await Fluttertoast.showToast(
          msg: "Item has been added to your cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } catch (e) {
      ErrorDialog(subtitle: e.toString(), context: context);
    }
  }

  static Future<void> addtoWishlist(
      {required String productId, required BuildContext context}) async {
    final wishListId = const Uuid().v1();
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;

    try {
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            'wishlistid': wishListId,
            'productId': productId,
          }
        ])
      });
      await Fluttertoast.showToast(
          msg: "Item has been added to your wishlist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } catch (e) {
      ErrorDialog(subtitle: e.toString(), context: context);
    }
  }
}
