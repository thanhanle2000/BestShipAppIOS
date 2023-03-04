import 'package:flutter/material.dart';

typedef OnTapCallback = void Function();

class OrderListMapButtonStatus extends StatelessWidget {
  final Color color;
  final String title;
  final OnTapCallback onTap;
  final double hw;
  const OrderListMapButtonStatus(
      {super.key,
      required this.color,
      required this.title,
      required this.onTap,
      required this.hw});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            height: 35,
            padding: EdgeInsets.only(left: hw, right: hw),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(7)),
            child: Text(title,
                style: const TextStyle(fontSize: 15, color: Colors.white))));
  }
}
