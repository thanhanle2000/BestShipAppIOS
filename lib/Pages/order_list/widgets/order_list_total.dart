import 'package:flutter/material.dart';

import '../../../Shared/blocs/theme/color.dart';

class OrderScanFailTotal extends StatelessWidget {
  final int total;
  const OrderScanFailTotal({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 0.125, color: Colours.textDefault))),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
        width: double.infinity,
        child: Row(children: [
          const Text('Tổng số đơn : ',
              style: TextStyle(fontSize: 15, color: Colours.textDefault)),
          Text('$total}',
              style: const TextStyle(
                  fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold))
        ]));
  }
}
