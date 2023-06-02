import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

import '../../services/utils.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextWidget(
            text: "Cart(2)",
            color: utils.color,
            textsize: 22,
            isTitle: true,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyBroken.delete),
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CartWidget();
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
