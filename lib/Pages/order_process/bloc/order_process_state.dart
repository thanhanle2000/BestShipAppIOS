import 'package:equatable/equatable.dart';
import 'package:flutter_app_best_shipp/Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/auth/tag_key/event_param_data.dart';
import '../../../Shared/models/order_scan/order_scan_list_shop.dart';
import '../../../Shared/models/status/status_models.dart';

// gộp 3 trạng thái vào 1 enum
enum OrderProcessStatus { initial, success, failure }

class OrderProcessState extends Equatable {
  final OrderProcessStatus status;
  final List<OrderModels> lstData;
  final bool hasReachedMax;
  final bool isFistLoaded;
  final int? total;
  final int? total_succsess;
  final int? total_processing;
  final int? total_other;
  final OrderListModels? data;
  final List<DataListShop> dataListShop;
  final EventDate? eventDate;
  final EventShopId? eventShopId;
  final EventSorts? eventSorts;
  final EventListStatus? eventListStatus;
  final EventTextFieldSearch? eventTextFields;
  final EventTextFieldPhone? eventTextFieldPhone;
  final List<int> number;
  final bool isCheck;
  final StatusData? actionStatus;
  final bool isCheckStatus;

  const OrderProcessState(
      {this.status = OrderProcessStatus.initial,
      this.lstData = const <OrderModels>[],
      this.hasReachedMax = false,
      this.isFistLoaded = true,
      this.total,
      this.total_succsess,
      this.total_other,
      this.total_processing,
      this.data,
      this.dataListShop = const <DataListShop>[],
      this.eventDate,
      this.eventShopId,
      this.eventListStatus,
      this.eventSorts,
      this.eventTextFields,
      this.eventTextFieldPhone,
      this.number = const <int>[],
      this.isCheck = false,
      this.actionStatus,
      this.isCheckStatus = false});

  // state copy -> đưa dữ liệu ra màn hình
  OrderProcessState copyWith(
      {OrderProcessStatus? status,
      bool? hasReachedMax,
      bool? isFistLoaded,
      int? total,
      int? total_succsess,
      int? total_processing,
      int? total_other,
      OrderListModels? data,
      List<OrderModels>? lstData,
      List<DataListShop>? dataListShop,
      EventDate? eventDate,
      EventShopId? eventShopId,
      EventSorts? eventSorts,
      EventListStatus? eventListStatus,
      EventTextFieldSearch? eventTextFields,
      EventTextFieldPhone? eventTextFieldPhone,
      List<int>? number,
      bool? isCheck,
      StatusData? actionStatus,
      bool? isCheckStatus}) {
    return OrderProcessState(
        status: status ?? this.status,
        lstData: lstData ?? this.lstData,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isFistLoaded: isFistLoaded ?? this.isFistLoaded,
        total: total ?? this.total,
        total_succsess: total_succsess ?? this.total_succsess,
        total_other: total_other ?? this.total_other,
        total_processing: total_processing ?? this.total_processing,
        data: data ?? this.data,
        dataListShop: dataListShop ?? this.dataListShop,
        eventDate: eventDate ?? this.eventDate,
        eventShopId: eventShopId ?? this.eventShopId,
        eventListStatus: eventListStatus ?? this.eventListStatus,
        eventSorts: eventSorts ?? this.eventSorts,
        eventTextFields: eventTextFields ?? this.eventTextFields,
        eventTextFieldPhone: eventTextFieldPhone ?? this.eventTextFieldPhone,
        number: number ?? this.number,
        isCheck: isCheck ?? this.isCheck,
        actionStatus: actionStatus ?? this.actionStatus,
        isCheckStatus: isCheckStatus ?? this.isCheckStatus);
  }

  @override
  String toString() {
    return '''PostState { isFistLoaded: $isFistLoaded
     ''';
    // return '''PostState {
    //   status: $status, hasReachedMax: $hasReachedMax, lstData: ${lstData.length},
    //  total: $total ,data: $data, total_succsess: $total_succsess, total_other:$total_other, total_processing:$total_processing,
    //  total_processing:$total_processing,dataListShop:$dataListShop ,
    // event: ${eventDate?.startDate}, ${eventDate?.endDate},${eventTextFields?.customerName},
    //                       ${eventTextFieldPhone?.customerPhone},${eventTextFields?.orderCode},${eventTextFields?.shopOrderCode},
    //                       ${eventSorts?.SortType},${eventShopId?.shopId},${eventListStatus?.orderStatus}''';
  }

  @override
  List<Object> get props => [
        status,
        lstData,
        hasReachedMax,
      ];
}
