import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/widgets/text_wiget.dart';
import 'package:provider/provider.dart';

import '../Prodivers/product_provider.dart';
import '../models/product_model.dart';
import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/empty_prod.dart';
import '../widgets/feed_item_widget.dart';
import '../widgets/on_sale_widget.dart';

class OnsaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnsaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> onSaleProducts = productProvider.getOnsaleProduct;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Product on sale',
          color: utils.color,
          textsize: 24,
          isTitle: true,
        ),
      ),
      body: onSaleProducts.isEmpty
          ? const EmptyProdWidget()
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio:
                  utils.screenSize.width * 2 / utils.screenSize.height,
              children: List.generate(
                onSaleProducts.length,
                (index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 2),
                      child: ChangeNotifierProvider.value(
                          value: onSaleProducts[index],
                          child: const OnSaleWidget()));
                },
              ),
            ),
    );
  }
}
