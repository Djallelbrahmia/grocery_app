import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key,
      required this.salePrice,
      required this.price,
      required this.textPrice,
      required this.isOnsle});
  final double salePrice, price;
  final String textPrice;
  final bool isOnsle;
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = utils.color;
    double userPrice = isOnsle ? salePrice : price;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
            text: "\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}",
            color: Colors.green,
            textsize: 22,
          ),
          const SizedBox(
            width: 5,
          ),
          Visibility(
            visible: isOnsle,
            child: Text(
              "\$${(price * int.parse(textPrice)).toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 15,
                  color: color,
                  decoration: TextDecoration.lineThrough),
            ),
          )
        ],
      ),
    );
  }
}
