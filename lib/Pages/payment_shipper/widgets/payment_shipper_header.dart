import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/blocs/theme/color.dart';

class PaymentShipperHeader extends StatelessWidget {
  final int totalPayment;
  const PaymentShipperHeader({super.key, required this.totalPayment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 0.25, color: Colours.textDefault))),
      child: Row(
        children: [
          const Text(
            'Tổng số phiếu:',
            style: TextStyle(fontSize: 15, color: Colours.classicText),
          ),
          const SizedBox(width: 3),
          Text(
            totalPayment.toString(),
            style: const TextStyle(
                fontSize: 15,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
