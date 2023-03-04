import 'package:flutter/material.dart';
import '../../blocs/theme/color.dart';

Widget navigationItem(context,
    {Color? boxColor,
    String? title,
    TextStyle? textStyle,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onTap}) {
  return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            color: boxColor,
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[
                Icon(icon, color: iconColor),
                const SizedBox(width: 30.0),
                Text(
                  title!,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 16.0, color: Colours.textDefault),
                )
              ]))));
}
