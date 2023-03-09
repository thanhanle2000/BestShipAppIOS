// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/bloc/order_scan_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/order_scan.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/order/order_respository.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScanScreen extends StatelessWidget {
  final OrderRespository _orderRespository;
  final UserRepository _userRepository;
  const OrderScanScreen(
      {super.key,
      required OrderRespository orderRespository,
      required UserRepository userRepository})
      : assert(orderRespository != null, userRepository != null),
        _orderRespository = orderRespository,
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderScanBloc>(
        create: (context) => OrderScanBloc(
            orderRespository: _orderRespository,
            userRepository: _userRepository),
        // ignore: prefer_const_constructors
        child: OrderScan());
  }
}
