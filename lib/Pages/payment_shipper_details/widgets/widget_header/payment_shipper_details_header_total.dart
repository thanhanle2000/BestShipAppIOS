import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Shared/blocs/theme/color.dart';
import '../../../../Shared/models/payment/payment_shipper_detail_models.dart';

class PaymentShipperDetailsHeaderTotal extends StatelessWidget {
  final PaymentShip data;

  const PaymentShipperDetailsHeaderTotal({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "vi_VN");
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'ĐH:',
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                Text(data.totalOrders != null ? ' ${data.totalOrders}' : '0',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colours.classicText,
                        fontWeight: FontWeight.w600))
              ],
            ),
            Row(
              children: [
                Text(
                  'COD: ',
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                Text(
                  data.totalCOD != null ? oCcy.format(data.totalCOD) : '0',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colours.classicText,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Phí giao hàng: ',
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                Text(
                    data.receivedPrice != null
                        ? oCcy.format(data.receivedPrice)
                        : '0',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colours.classicText,
                        fontWeight: FontWeight.w600))
              ],
            ),
            Row(
              children: [
                Row(
                  children: [
                    Text(
                      'Còn lại:',
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 4),
                    Text(
                        data.totalRemain != null
                            ? oCcy.format(data.totalRemain)
                            : '0',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colours.classicText,
                            fontWeight: FontWeight.w600))
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
