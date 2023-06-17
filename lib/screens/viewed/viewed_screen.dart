import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Prodivers/viewd_product_provider.dart';
import 'package:grocery_app/screens/viewed/viewed_widget.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:provider/provider.dart';

import '../../services/global_methodes.dart';
import '../../widgets/empty_cart_screen.dart';
import '../../widgets/text_wiget.dart';

class ViewedSCreen extends StatefulWidget {
  const ViewedSCreen({super.key});
  static final String routeName = "/ViewedScreen";

  @override
  State<ViewedSCreen> createState() => _ViewedSCreenState();
}

class _ViewedSCreenState extends State<ViewedSCreen> {
  @override
  Widget build(BuildContext context) {
    final viewdProdProvider = Provider.of<ViewdProdProvider>(context);
    final viewdListItems =
        viewdProdProvider.getViewdItems.values.toList().reversed.toList();
    final Utils utils = Utils(context);
    return viewdListItems.isEmpty
        ? const EmptyCartScreen(
            title: "Your history is empty",
            subtitle: "No items has been viewd recently",
            buttontext: "Shop now",
            imagePath: 'assets/images/history.png',
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const BackWidget(),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: "Viewed items",
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
                        subtitle: "Are you sure you wanna your  history ? ",
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
              itemCount: viewdListItems.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ChangeNotifierProvider.value(
                    value: viewdListItems[index], child: const ViewedWidget()),
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
  }
}
