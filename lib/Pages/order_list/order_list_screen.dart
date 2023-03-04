import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/order/order_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/order_list_bloc.dart';
import 'order_list.dart';

class OrderListScreen extends StatelessWidget {
  final int totalOrder;
  final String title;
  final OrderRespository repository;

  const OrderListScreen(
      {super.key,
      required this.repository,
      required this.totalOrder,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OrderListBloc(repository),
        // ignore: prefer_const_constructors
        child: OrderList(title: title));
  }
}
