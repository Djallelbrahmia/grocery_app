import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Prodivers/product_provider.dart';
import 'package:grocery_app/models/orders_model.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final ordersModel = Provider.of<OrderModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productProvider.findById(ordersModel.productId);
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: FancyShimmerImage(
          width: utils.screenSize.width * 0.2,
          boxFit: BoxFit.fill,
          boxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          imageUrl: getCurrProduct.imageUrl,
        ),
      ),
      title: TextWidget(
        text: getCurrProduct.title,
        color: utils.color,
        textsize: 18,
        isTitle: true,
      ),
      subtitle: TextWidget(
        text: 'Paid: \$${double.parse(ordersModel.price).toStringAsFixed(2)}',
        color: utils.color,
        textsize: 18,
        isTitle: false,
      ),
      trailing:
          TextWidget(text: orderDateToShow, color: utils.color, textsize: 18),
    );
  }
}
