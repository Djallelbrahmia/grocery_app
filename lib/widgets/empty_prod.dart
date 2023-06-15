import 'package:flutter/material.dart';

import '../services/utils.dart';

class EmptyProdWidget extends StatelessWidget {
  const EmptyProdWidget(
      {super.key, this.text = "No Product on sale yet !,\nStay tuned"});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.asset("assets/images/box.png"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Utils(context).color,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
