import 'package:flutter/material.dart';

class OrderProcessActionCir extends StatelessWidget {
  final String title;
  final Color color;
  final IconData iconData;
  final double lr;
  final void Function()? onTap;
  const OrderProcessActionCir(
      {super.key,
      required this.title,
      required this.color,
      required this.iconData,
      required this.onTap,
      required this.lr});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: lr, right: lr),
        color: color,
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            const SizedBox(width: 3),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
