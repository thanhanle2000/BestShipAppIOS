import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_details/payment_shipper_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/repositories/payment/payment_respository.dart';
import 'bloc/payment_shipper_detail_bloc.dart';

class PaymentShipperDetailScreen extends StatelessWidget {
  final PaymentRespository _paymentRespository;
  const PaymentShipperDetailScreen(
      {super.key, required PaymentRespository paymentRespository})
      // ignore: unnecessary_null_comparison
      : assert(paymentRespository != null),
        _paymentRespository = paymentRespository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            PaymentShipperDetailsBloc(paymentRespository: _paymentRespository),
        // ignore: prefer_const_constructors
        child: PaymentShipperDetails());
  }
}
