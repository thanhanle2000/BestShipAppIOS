import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/widgets/payment_shipper_info.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/widgets/payment_shipper_status.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/widgets/payment_shipper_total.dart';
import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/models/payment/payment_shipper_models.dart';

class PaymentShipperBody extends StatelessWidget {
  final PaymentModels data;

  const PaymentShipperBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var colors = data.isConfirm! ? Colours.colorStatus1 : Colours.colorStatus;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3) // changes position of shadow
                  )
            ],
            border: Border(
                left: BorderSide(width: .1, color: colors),
                right: BorderSide(width: .1, color: colors),
                top: BorderSide(width: 3.0, color: colors),
                bottom: BorderSide(width: .1, color: colors))),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentShipperInfo(data: data),
              const SizedBox(height: 5),
              PaymentShipperTotal(data: data),
              const SizedBox(height: 5),
              PaymentShipperStatus(data: data)
            ]));
  }
}
