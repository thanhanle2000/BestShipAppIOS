import 'package:flutter/material.dart';

import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/utils/app_utils.dart';

class GetIncomeHeaderTotal extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const GetIncomeHeaderTotal({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          const Text('Shipper: ',
              style: TextStyle(fontSize: 16, color: Colours.textDefault)),
          const SizedBox(width: 10),
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colours.textDefault)))
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  backgroundColor: fromHexColor(Constants.COLOR_BUTTON)),
              onPressed: onPressed,
              child: const Text('Cập nhật', style: TextStyle(fontSize: 15)))
        ])
      ]),
    );
  }
}
