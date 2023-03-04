import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/models/auth/auth_models.dart';
import '../../../Shared/models/payment/payment_shipper_models.dart';
import '../../../Shared/preferences/preferences.dart';

class PaymentShipperTotal extends StatelessWidget {
  final PaymentModels data;

  const PaymentShipperTotal({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "vi_VN");
    String? name = Prefer.prefs?.getString('authenticationViewModel');
    final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Text('COD: ',
              style: TextStyle(fontSize: 15, color: Colors.grey[600])),
          const SizedBox(width: 4),
          Text(oCcy.format(data.totalCOD),
              style: const TextStyle(
                  fontSize: 15,
                  color: Colours.classicText,
                  fontWeight: FontWeight.w600))
        ]),
        Row(children: [
          Text('Ship: ',
              style: TextStyle(fontSize: 15, color: Colors.grey[600])),
          Text(oCcy.format(data.receivedPrice),
              style: const TextStyle(
                  fontSize: 15,
                  color: Colours.classicText,
                  fontWeight: FontWeight.w600))
        ])
      ]),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        username.userType == 4
            ? const SizedBox()
            : Row(children: [
                Text('Tổng cộng:',
                    style: TextStyle(fontSize: 15, color: Colors.grey[600])),
                const SizedBox(width: 4),
                Text(oCcy.format(data.totalPrice),
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colours.classicText,
                        fontWeight: FontWeight.w600))
              ]),
        Row(children: [
          Row(children: [
            Text('Còn lại:',
                style: TextStyle(fontSize: 15, color: Colors.grey[600])),
            const SizedBox(width: 4),
            Text(oCcy.format(data.totalRemain),
                style: const TextStyle(
                    fontSize: 15,
                    color: Colours.classicText,
                    fontWeight: FontWeight.w600))
          ])
        ])
      ])
    ]);
  }
}
