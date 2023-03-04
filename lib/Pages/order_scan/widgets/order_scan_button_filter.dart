import 'package:flutter/material.dart';
import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/utils/app_utils.dart';

// button lọc sử dụng trong ui scan -> kế bên title Hôm nay
class OrderScanButtonFilter extends StatelessWidget {
  final IconData icon;
  final void Function() onpress;
  final String title;
  const OrderScanButtonFilter(
      {super.key,
      required this.onpress,
      required this.icon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        color: Colors.white,
        padding: const EdgeInsets.only(left: 5, bottom: 5, top: 8, right: 10),
        height: 40,
        width: double.infinity,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colours.textDefault)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: fromHexColor(Constants.COLOR_BUTTON)),
                  onPressed: onpress,
                  child: const Text('Lọc'))
            ]));
  }
}
