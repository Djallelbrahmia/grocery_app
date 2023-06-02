import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../services/utils.dart';

class HeartButton extends StatelessWidget {
  const HeartButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    final them = Utils(context).getTheme;
    Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {},
      child: Icon(
        IconlyLight.heart,
        size: 24,
        color: color,
      ),
    );
  }
}
