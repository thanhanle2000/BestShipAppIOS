import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/bloc/payment_shipper_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/payment_shipper.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/payment/payment_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentShipperScreen extends StatelessWidget {
  final PaymentRespository _paymentRespository;
  const PaymentShipperScreen(
      {super.key, required PaymentRespository paymentRespository})
      : _paymentRespository = paymentRespository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentShipperBloc>(
        create: (context) =>
            PaymentShipperBloc(paymentRespository: _paymentRespository),
        child: const PaymentShipper());
  }
}
