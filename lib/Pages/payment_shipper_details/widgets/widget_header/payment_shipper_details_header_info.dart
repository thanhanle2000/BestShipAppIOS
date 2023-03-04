import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Shared/blocs/theme/color.dart';
import '../../../../Shared/constants/constants.dart';
import '../../../../Shared/models/payment/payment_shipper_detail_models.dart';
import '../../../../Shared/utils/app_utils.dart';

class PaymentShipperDetailsHeaderInfo extends StatelessWidget {
  final PaymentShip data;
  const PaymentShipperDetailsHeaderInfo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Mã phiếu:',
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            Text(
              data.id != null ? ' ${data.id}' : "0",
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        Text(
          data.userName != null ? '${data.userName}' : '',
          style: const TextStyle(
              color: Colours.classicText,
              fontSize: 15.0,
              fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            Icon(Icons.date_range,
                color: fromHexColor(Constants.COLOR_BUTTON), size: 15),
            const SizedBox(width: 4),
            Text(
                data.paymentDate != null
                    ? DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(data.paymentDate!))
                    : '0',
                style:
                    const TextStyle(fontSize: 15, color: Colours.classicText))
          ],
        ),
      ],
    );
  }
}
