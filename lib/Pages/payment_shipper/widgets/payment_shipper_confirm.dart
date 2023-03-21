import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/utils/app_utils.dart';

class PaymentShipperConfirm extends StatelessWidget {
  final void Function() onpress;
  final String title;
  final String colorString;
  final double lr;
  const PaymentShipperConfirm(
      {super.key,
      required this.onpress,
      required this.title,
      required this.colorString,
      required this.lr});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: fromHexColor(colorString)),
        onPressed: onpress,
        child: Padding(
            padding: EdgeInsets.only(left: lr, right: lr),
            child: Text(title, style: const TextStyle(fontSize: 15))));
  }
}
