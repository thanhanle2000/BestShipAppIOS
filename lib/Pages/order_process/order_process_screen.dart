import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/order/order_respository.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/order_process_bloc.dart';
import 'order_process.dart';

class OrderProcessScreen extends StatelessWidget {
  const OrderProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderProcessBloc(
          orderRespository: OrderRespository(ShopId: 0, dateNow: ''),
          userRepository: UserRepository()),
      child: const OrderProcess(),
    );
  }
}
