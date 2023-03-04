import 'package:flutter/material.dart';
import '../../../Shared/blocs/theme/color.dart';

class OrderScanButton extends StatelessWidget {
  final String title;
  final String text;
  final void Function() ontap;
  const OrderScanButton(
      {super.key,
      required this.title,
      required this.text,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
            height: 40,
            padding: const EdgeInsets.only(left: 5),
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text,
                      style: const TextStyle(
                          fontSize: 16, color: Colours.textDefault)),
                  Row(children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colours.textDefault)),
                    const Icon(Icons.navigate_next)
                  ])
                ])));
  }
}
