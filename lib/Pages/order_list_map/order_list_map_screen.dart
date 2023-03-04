// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/repositories/order/order_respository.dart';
import '../../presentation/repositories/order/order_map_repository.dart';
import 'bloc/map_bloc.dart';
import 'order_list_map.dart';

class OrderListMapScreen extends StatelessWidget {
  final MapRepository _mapRepository;
  final OrderRespository _orderRespository;

  const OrderListMapScreen(
      {super.key,
      required MapRepository mapRepository,
      required OrderRespository orderRespository})
      : assert(mapRepository != null, orderRespository != null),
        _mapRepository = mapRepository,
        _orderRespository = orderRespository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
      create: (context) => MapBloc(
          mapRepository: _mapRepository, orderRespository: _orderRespository),
      // ignore: prefer_const_constructors
      child: OrderListMap(),
    );
  }
}
