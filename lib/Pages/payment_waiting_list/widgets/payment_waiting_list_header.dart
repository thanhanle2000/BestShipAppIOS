import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_waiting_list/widgets/payment_waiting_list_header_info.dart';
import 'package:flutter_app_best_shipp/Pages/payment_waiting_list/widgets/payment_waiting_list_header_total.dart';
import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/models/payment/payment_shipper_detail_models.dart';

class PaymentWaitingListHeader extends StatelessWidget {
  final PaymentShip data;

  const PaymentWaitingListHeader({super.key, required this.data});

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
          PaymentWaitingHeaderInfo(data: data),
          const SizedBox(height: 5),
          PaymentWaitingListHeaderTotal(data: data)
        ],
      ),
    );
  }
}
