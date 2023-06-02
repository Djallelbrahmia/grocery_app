import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_screen.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/quantity_controller_widget.dart';
import 'package:grocery_app/widgets/text_wiget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = "1";
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductScreen.routeName);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      height: utils.screenSize.width * 0.25,
                      width: utils.screenSize.width * 0.2,
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: FancyShimmerImage(
                          imageUrl:
                              "https://www.aprifel.com/wp-content/uploads/2019/02/abricot.jpg",
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: "Title",
                          color: utils.color,
                          textsize: 20,
                          isTitle: true,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: utils.screenSize.width * 0.24,
                          child: Row(
                            children: [
                              QuantityController(
                                  fct: () {
                                    if (_quantityTextController.text == "1") {
                                      return;
                                    } else {
                                      setState(() {
                                        _quantityTextController.text =
                                            (int.parse(_quantityTextController
                                                        .text) -
                                                    1)
                                                .toString();
                                      });
                                    }
                                  },
                                  icon: CupertinoIcons.minus,
                                  color: Colors.red),
                              Flexible(
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    )
                                  ],
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        _quantityTextController.text = "1";
                                      });
                                    }
                                  },
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide())),
                                ),
                              ),
                              QuantityController(
                                  fct: () {
                                    setState(() {
                                      _quantityTextController.text = (int.parse(
                                                  _quantityTextController
                                                      .text) +
                                              1)
                                          .toString();
                                    });
                                  },
                                  icon: CupertinoIcons.plus,
                                  color: Colors.green),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: HeartButton(),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              CupertinoIcons.cart_badge_plus,
                              color: const Color.fromARGB(255, 169, 39, 29),
                            ),
                          ),
                          TextWidget(
                            text: '\$0.29',
                            color: utils.color,
                            textsize: 18,
                            maxLine: 1,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
