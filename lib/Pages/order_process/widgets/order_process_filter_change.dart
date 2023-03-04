import 'package:flutter/material.dart';

class OrderProcessFilterChange extends StatelessWidget {
  final String title;
  final double padleft;
  final IconData iconData;
  final Color color;
  final Color colorIcon;
  final Color colorText;
  final void Function() onTap;

  const OrderProcessFilterChange(
      {super.key,
      required this.title,
      required this.padleft,
      required this.iconData,
      required this.color,
      required this.onTap,
      required this.colorIcon,
      required this.colorText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        color: color,
        width: MediaQuery.of(context).size.width * 0.333,
        padding: EdgeInsets.only(left: padleft),
        child: Row(
          children: [
            Icon(
              iconData,
              color: colorIcon,
            ),
            const SizedBox(width: 3),
            Text(
              title.length > 10 ? '${title.substring(0, 10)}...' : title,
              style: TextStyle(fontSize: 15, color: colorText),
            ),
          ],
        ),
      ),
    );
  }
}
