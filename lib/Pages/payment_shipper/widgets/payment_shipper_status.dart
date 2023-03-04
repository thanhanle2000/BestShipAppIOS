import 'package:flutter/material.dart';

import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/models/payment/payment_shipper_models.dart';
import '../../../Shared/utils/app_utils.dart';

class PaymentShipperStatus extends StatelessWidget {
  final PaymentModels data;

  const PaymentShipperStatus({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var colors = data.isConfirm!
        ? fromHexColor(Constants.COLOR_BUTTON)
        : fromHexColor(Constants.COLOR_APPBAR);
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.comment,
                color: fromHexColor(Constants.COLOR_APPBAR), size: 15),
            const SizedBox(width: 4),
            Text(
              '${data.paymentName}',
              style: const TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colours.classicText,
                  decoration: TextDecoration.underline),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: colors,
                  border: Border.all(
                    color: colors,
                  )),
              child: Text(data.isConfirm! ? 'Đã xác nhận' : 'Chưa xác nhận',
                  style: const TextStyle(fontSize: 15, color: Colors.white)),
            ),
          ],
        )
      ],
    );
  }
}
