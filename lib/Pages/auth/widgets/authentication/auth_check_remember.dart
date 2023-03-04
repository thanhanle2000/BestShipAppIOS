import 'package:flutter/material.dart';

import '../../../../Shared/blocs/theme/color.dart';

class AuthCheckRememberMe extends StatelessWidget {
  final Function(bool?) onChanged;
  final bool checkValue;
  final String title;
  const AuthCheckRememberMe(
      {super.key,
      required this.onChanged,
      required this.checkValue,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
          width: 18,
          child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              activeColor: Colors.grey[200],
              checkColor: Colours.active_button,
              value: checkValue,
              onChanged: onChanged)),
      const SizedBox(width: 5),
      Text(title,
          style: const TextStyle(fontSize: 18, color: Colours.textDefault))
    ]);
  }
}
