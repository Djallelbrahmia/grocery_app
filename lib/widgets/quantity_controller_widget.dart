import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuantityController extends StatelessWidget {
  const QuantityController(
      {super.key, required this.fct, required this.icon, required this.color});
  final Function fct;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {
              fct();
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
