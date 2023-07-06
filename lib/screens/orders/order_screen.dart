import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:provider/provider.dart';

import '../../Prodivers/orders_provider.dart';
import '../../services/global_methodes.dart';
import '../../widgets/empty_cart_screen.dart';
import '../../widgets/text_wiget.dart';
import 'order_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static final String routeName = "/OrderScreen";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final orders = orderProvider.getOrders;
    return orders.isEmpty
        ? const EmptyCartScreen(
            title: "You didn't order anything recently",
            subtitle: "Order Something and make me happy",
            buttontext: "Shop now",
            imagePath: 'assets/images/cart.png',
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const BackWidget(),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: "Orders history [${orders.length}]",
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
                        subtitle:
                            "Are you sure you wanna your orders history ? ",
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
            body: ListView.separated(
              itemCount: orders.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ChangeNotifierProvider.value(
                    value: orders[index], child: const OrderWidget()),
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
  }
}
