import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_waiting_list/bloc/payment_waiting_list_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/payment_waiting_list/payment_waiting_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/repositories/payment/payment_respository.dart';

class PaymentWaitingListScreen extends StatelessWidget {
  final PaymentRespository _paymentRespository;
  const PaymentWaitingListScreen(
      {super.key, required PaymentRespository paymentRespository})
      // ignore: unnecessary_null_comparison
      : assert(paymentRespository != null),
        _paymentRespository = paymentRespository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentWaitingBloc>(
      create: (context) =>
          PaymentWaitingBloc(paymentRespository: _paymentRespository),
      // ignore: prefer_const_constructors
      child: PaymentWaitingList(),
    );
  }
}
