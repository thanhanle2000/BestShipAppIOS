import 'package:flutter/material.dart';
import '../../../Shared/blocs/theme/color.dart';

class OrderScanListItem extends StatelessWidget {
  final Function()? onTap;
  final String name;
  const OrderScanListItem({super.key, this.onTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            height: 50,
            color: Colors.white,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 5, right: 10, top: 1),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Divider(
                height: 1.0,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 15),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 15, color: Colours.textDefault),
              )
            ])));
  }
}
