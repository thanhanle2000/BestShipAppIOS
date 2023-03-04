import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/models/payment/payment_shipper_models.dart';
import '../../../Shared/utils/app_utils.dart';

class PaymentShipperInfo extends StatelessWidget {
  final PaymentModels data;

  const PaymentShipperInfo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#${data.id}',
              style: const TextStyle(
                  color: Colours.classicText,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '${data.userName}',
              style: const TextStyle(
                  color: Colours.classicText,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.date_range,
                    color: fromHexColor(Constants.COLOR_BUTTON), size: 15),
                const SizedBox(width: 4),
                Text(
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(data.paymentDate!)),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colours.classicText))
              ],
            ),
            Row(
              children: [
                Text(
                  'ĐH:',
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                Text('${data.totalOrders}',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colours.classicText,
                        fontWeight: FontWeight.w600))
              ],
            )
          ],
        ),
      ],
    );
  }
}
