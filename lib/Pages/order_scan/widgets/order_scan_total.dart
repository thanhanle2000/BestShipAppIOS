import 'package:flutter/material.dart';
import '../../../Shared/blocs/theme/color.dart';

//lấy giá trị total cho ui scan oder (tổng, đã quét, sót)
class OrderScanTotal extends StatelessWidget {
  final int total;
  final String title;
  final Color color;
  const OrderScanTotal(
      {super.key,
      required this.total,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 15),
        color: Colors.white,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Text('$title ',
                style:
                    const TextStyle(fontSize: 16, color: Colours.textDefault))
          ]),
          Text('$total',
              style: TextStyle(
                  fontSize: 20, color: color, fontWeight: FontWeight.bold))
        ]));
  }
}
