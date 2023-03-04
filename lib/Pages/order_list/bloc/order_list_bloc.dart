import 'package:flutter_app_best_shipp/Shared/models/order_list/order_list_models.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/order/order_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_list_state.dart';

class OrderListBloc extends Cubit<OrderListState> {
  OrderListBloc(this.repository) : super(OrderListStartedEvent());
  final OrderRespository repository;

  int page = 1;

  void loadPosts() {
    if (state is OrderListGetDataEvent) return;
    final currentState = state;

    var lstData = <OrderModels>[];
    if (currentState is OrderListLoadingEvent) {
      lstData = currentState.data;
    }

    emit(OrderListGetDataEvent(lstData, isLoading: page == 1));

    repository.getData(page).then((newData) {
      page++;

      final data = (state as OrderListGetDataEvent).getData;
      data.addAll(newData.data ?? []);

      emit(OrderListLoadingEvent(data, newData.total!));
    });
  }
}
