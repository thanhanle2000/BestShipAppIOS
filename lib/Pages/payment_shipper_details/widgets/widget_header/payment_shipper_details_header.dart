import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_details/widgets/widget_header/payment_shipper_details_header_info.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_details/widgets/widget_header/payment_shipper_details_header_total.dart';
import '../../../../Shared/blocs/theme/color.dart';
import '../../../../Shared/models/payment/payment_shipper_detail_models.dart';

class PaymentShipperDetailsHeader extends StatelessWidget {
  final PaymentShip data;
  const PaymentShipperDetailsHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 0.25, color: Colours.textDefault))),
      child: Column(
        children: [
          PaymentShipperDetailsHeaderInfo(data: data),
          const SizedBox(height: 5),
          PaymentShipperDetailsHeaderTotal(data: data)
        ],
      ),
    );
  }
}
