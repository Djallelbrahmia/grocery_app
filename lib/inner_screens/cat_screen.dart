import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Prodivers/product_provider.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:provider/provider.dart';

import '../consts/consts.dart';
import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/empty_prod.dart';
import '../widgets/feed_item_widget.dart';
import '../widgets/on_sale_widget.dart';
import '../widgets/text_wiget.dart';

class CategoryFeedsScreen extends StatefulWidget {
  static const routeName = "/CategoryScreen";

  const CategoryFeedsScreen({super.key});

  @override
  State<CategoryFeedsScreen> createState() => _CategoryFeedsScreenState();
}

class _CategoryFeedsScreenState extends State<CategoryFeedsScreen> {
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
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> searchResult = [];

    List<ProductModel> productByCat =
        productProvider.findByCategory(categoryName);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: const BackWidget(),
          centerTitle: true,
          title: TextWidget(
            text: categoryName,
            color: utils.color,
            textsize: 20,
            isTitle: true,
          ),
        ),
        body: productByCat.isEmpty
            ? const EmptyProdWidget(text: "No Product belong to this category!")
            : SingleChildScrollView(
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
                            setState(() {
                              searchResult = productProvider.searchQuery(value);
                            });
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 0.3),
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
                    _searchTextController.text.isNotEmpty &&
                            searchResult.isEmpty
                        ? const EmptyProdWidget(
                            text:
                                "No Product Found , please try another keyword",
                          )
                        : GridView.count(
                            crossAxisCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            childAspectRatio: utils.screenSize.width /
                                (utils.screenSize.height * 0.59),
                            children: List.generate(
                                _searchTextController.text.isNotEmpty
                                    ? searchResult.length
                                    : productByCat.length, (index) {
                              return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 2),
                                  child: SizedBox(
                                    child: ChangeNotifierProvider.value(
                                        value: _searchTextController
                                                .text.isNotEmpty
                                            ? searchResult[index]
                                            : productByCat[index],
                                        child: FeedWidget()),
                                  ));
                            })),
                  ],
                ),
              ));
  }
}
