import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/global_methodes.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

import '../services/utils.dart';
import '../widgets/feed_item_widget.dart';
import '../widgets/on_sale_widget.dart';

class OnsaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnsaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final bool _isEmpty = false;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: TextWidget(
          text: 'Product on sale',
          color: utils.color,
          textsize: 24,
          isTitle: true,
        ),
      ),
      body: _isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/box.png"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'No Product on sale yet !,\nStay tuned',
                        style: TextStyle(
                          color: utils.color,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio:
                  utils.screenSize.width * 2 / utils.screenSize.height,
              children: List.generate(
                16,
                (index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 2),
                      child: OnSaleWidget());
                },
              ),
            ),
    );
  }
}
