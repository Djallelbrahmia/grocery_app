import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../services/utils.dart';
import '../widgets/feed_item_widget.dart';
import '../widgets/on_sale_widget.dart';
import '../widgets/text_wiget.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = "/FeedsScreen";

  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    return Scaffold(
        appBar: AppBar(
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
          centerTitle: true,
          title: TextWidget(
            text: 'All Product',
            color: utils.color,
            textsize: 20,
            isTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: kBottomNavigationBarHeight,
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _searchTextController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 0.3),
                        ),
                        hintText: "Whats in your mind",
                        prefixIcon: Icon(IconlyLight.search),
                        suffix: IconButton(
                            onPressed: () {
                              _searchTextController.clear();
                              _focusNode.unfocus();
                            },
                            icon: Icon(
                              Icons.close,
                              color: _focusNode.hasFocus
                                  ? Colors.red
                                  : utils.color,
                            ))),
                  ),
                ),
              ),
              GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio:
                      utils.screenSize.width / (utils.screenSize.height * 0.59),
                  children: List.generate(20, (index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 2),
                        child: FeedWidget());
                  })),
            ],
          ),
        ));
  }
}
