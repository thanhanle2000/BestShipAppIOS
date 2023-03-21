import 'package:flutter/material.dart';

class OrderListButtonConfirmFilter extends StatelessWidget {
  final String title;
  final double hw;
  final Color color;

  final void Function() onpress;
  const OrderListButtonConfirmFilter(
      {super.key,
      required this.onpress,
      required this.hw,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: hw, right: hw),
        alignment: Alignment.center,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                backgroundColor: color),
            onPressed: onpress,
            child: Container(
                padding: EdgeInsets.only(left: hw, right: hw),
                height: 50,
                child: Center(
                    child:
                        Text(title, style: const TextStyle(fontSize: 18))))));
  }
}
