import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/models/orders_model.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:uuid/uuid.dart';

class OrderProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    final User? user = authInstance.currentUser;
    await FirebaseFirestore.instance
        .collection("orders")
        .where('userId', isEqualTo: user!.uid)
        .orderBy('orderDate', descending: false)
        .get()
        .then((QuerySnapshot ordersSnapshot) => {
              ordersSnapshot.docs.forEach((element) {
                _orders = [];
                _orders.insert(
                    0,
                    OrderModel(
                        imageUrl: element.get('imageUrl'),
                        orderDate: element.get('orderDate'),
                        orderId: element.get('orderId'),
                        price: element.get('price').toString(),
                        productId: element.get('productId'),
                        quantity: element.get('quantity').toString(),
                        userId: element.get('userId'),
                        totalPrice: element.get('totalPrice').toString(),
                        userName: element.get('userName')));
              })
            });
    notifyListeners();
  }
}
