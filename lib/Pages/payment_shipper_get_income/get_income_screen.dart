import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_get_income/get_income.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/repositories/payment/payment_respository.dart';
import 'bloc/get_income_bloc.dart';

class GetIcomeScreen extends StatelessWidget {
  final PaymentRespository _paymentRespository;
  final UserRepository _userRepository;
  const GetIcomeScreen(
      {super.key,
      required PaymentRespository paymentRespository,
      required UserRepository userRepository})
      : _paymentRespository = paymentRespository,
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetIncomeBloc>(
        create: (context) => GetIncomeBloc(
            paymentRespository: _paymentRespository,
            userRepository: _userRepository),
        child: const GetIncome());
  }
}
