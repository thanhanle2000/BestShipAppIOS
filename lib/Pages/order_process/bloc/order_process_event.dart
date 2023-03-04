import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_bloc.dart';

import '../../../Shared/models/status/status_models.dart';

abstract class OrderProcessEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderProcessStartedEvent extends OrderProcessEvent {
  OrderProcessStartedEvent();
}

class OrderProcessKeyEvent extends OrderProcessEvent {
  final String key;
  OrderProcessKeyEvent({required this.key});
}

// event date
// ignore: must_be_immutable
class OrderProcessFilterDateEvent extends OrderProcessEvent {
  String? startDate;
  String? endDate;
  OrderProcessBloc? processBloc;
  BuildContext? blocContext;
  OrderProcessFilterDateEvent(
      {this.startDate, this.endDate, this.processBloc, this.blocContext});
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'OrderProcessFilterDateEvent { startDate: $startDate , endDate: $endDate}';
  }
}

// event search textfield
class OrderProcessFilterTextFieldEvent extends OrderProcessEvent {
  String? customerName;
  String? orderCode;
  String? shopOrderCode;
  OrderProcessBloc? processBloc;
  BuildContext? blocContext;
  OrderProcessFilterTextFieldEvent(
      {this.customerName,
      this.orderCode,
      this.shopOrderCode,
      this.processBloc,
      this.blocContext});
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'OrderProcessFilterTextFieldEvent { customerName: $customerName,' +
        ' shopOrderCode: $shopOrderCode, orderCode: $orderCode,}';
  }
}

// event shop id
class OrderProcessFilterShopIdEvent extends OrderProcessEvent {
  int? shopId;
  OrderProcessBloc? processBloc;
  BuildContext? blocContext;
  OrderProcessFilterShopIdEvent(
      {this.shopId, this.processBloc, this.blocContext});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'OrderProcessFilterShopIdEvent {shopId: $shopId}';
  }
}

// event list status
class OrderProcessFilterStatusEvent extends OrderProcessEvent {
  List<int>? orderStatus;
  OrderProcessBloc? processBloc;
  BuildContext? blocContext;
  OrderProcessFilterStatusEvent(
      {this.orderStatus, this.processBloc, this.blocContext});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'OrderProcessFilterStatusEvent {orderStatus: $orderStatus}';
  }
}

class OrderProcessFilterPhoneEvent extends OrderProcessEvent {
  String? customerPhone;
  OrderProcessBloc? processBloc;
  BuildContext? blocContext;
  OrderProcessFilterPhoneEvent(
      {this.customerPhone, this.processBloc, this.blocContext});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'OrderProcessFilterPhoneEvent {customerPhone: $customerPhone}';
  }
}

class OrderProcessFilterSortEvent extends OrderProcessEvent {
  String? SortType;
  OrderProcessBloc? processBloc;
  BuildContext? blocContext;
  OrderProcessFilterSortEvent(
      {this.SortType, this.processBloc, this.blocContext});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'OrderProcessFilterSortEvent {SortType: $SortType}';
  }
}

class OrderProcessFilterEvent extends OrderProcessEvent {
  String? startDate;
  String? endDate;
  String? customerPhone;
  String? customerName;
  String? orderCode;
  String? shopOrderCode;
  String? SortType;
  int? shopId;
  List<int>? orderStatus;
  OrderProcessBloc? processBloc;
  BuildContext? blocContext;
  bool? isCheck;
  OrderProcessFilterEvent(
      {this.startDate,
      this.endDate,
      this.customerPhone,
      this.customerName,
      this.orderCode,
      this.shopOrderCode,
      this.SortType,
      this.shopId,
      this.orderStatus,
      this.processBloc,
      this.blocContext,
      this.isCheck});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'OrderProcessFilterEvent { startDate: $startDate , endDate: $endDate, customerName: $customerName,' +
        ' customerPhone: $customerPhone, orderCode: $orderCode,SortType: $SortType, shopId: $shopId, orderStatus: $orderStatus}';
  }
}

class OrderProcessSuccessEvent extends OrderProcessEvent {
  int? shopId;
  String? code;
  String? shipper;
  StatusData? statusModels;
  OrderProcessBloc? processBloc;
  BuildContext? blocContext;

  OrderProcessSuccessEvent({
    this.shopId,
    this.code,
    this.shipper,
    this.statusModels,
    this.blocContext,
    this.processBloc,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'MapBlocEventSuccessEvent { shopId: $shopId, code: $code, shipper: $shipper, statusModels : $statusModels }';
  }
}

class OrderProcessCancelEvent extends OrderProcessEvent {
  int? shopId;
  String? code;
  String? shipper;
  int? CancelId;
  String? cancelReason;
  StatusData? statusModels;
  OrderProcessBloc? processBloc;
  BuildContext? blocContext;

  OrderProcessCancelEvent(
      {this.shopId,
      this.code,
      this.shipper,
      this.CancelId,
      this.cancelReason,
      this.statusModels,
      this.blocContext,
      this.processBloc});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'OrderProcessCancelEvent { shopId: $shopId, code: $code, shipper: $shipper, CancelId: $CancelId,cancelReason : $cancelReason ,statusModels : $statusModels }';
  }
}

class OrderProcessChangeActionEvent extends OrderProcessEvent {
  int? shopId;
  String? code;
  int? action_item_id;
  int? action_call_time;
  String? shipper;
  int? action_id;
  String? action_text;
  StatusData? statusModels;
  OrderProcessBloc? processBloc;
  BuildContext? blocContext;

  OrderProcessChangeActionEvent(
      {this.shopId,
      this.code,
      this.action_item_id,
      this.action_call_time,
      this.shipper,
      this.action_id,
      this.action_text,
      this.statusModels,
      this.blocContext,
      this.processBloc});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'OrderProcessChangeActionEvent { shopId: $shopId, code: $code, action_item_id: $action_item_id, action_call_time: $action_call_time,shipper : $shipper,action_id: $action_id ,statusModels : $statusModels }';
  }
}
