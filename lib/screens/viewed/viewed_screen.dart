import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/viewed/viewed_widget.dart';
import 'package:grocery_app/services/utils.dart';

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
    final bool _isEmpty = true;
    final Utils utils = Utils(context);
    return _isEmpty
        ? const EmptyCartScreen(
            title: "Your history is empty",
            subtitle: "No items has been viewd recently",
            buttontext: "Shop now",
            imagePath: 'assets/images/history.png',
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  IconlyLight.arrowLeft2,
                  color: utils.color,
                  size: 24,
                ),
              ),
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
              itemCount: 10,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ViewedWidget(),
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
  }
}
