import '../../../Shared/models/order_list/order_list_models.dart';

abstract class OrderListState {}

class OrderListStartedEvent extends OrderListState {}

// load data ra khi có emit
class OrderListLoadingEvent extends OrderListState {
  final List<OrderModels> data;
  final int totalOrder;

  OrderListLoadingEvent(this.data, this.totalOrder);
}

class OrderListGetDataEvent extends OrderListState {
  final List<OrderModels> getData;
  final bool isLoading;

  OrderListGetDataEvent(this.getData, {this.isLoading = false});
}
