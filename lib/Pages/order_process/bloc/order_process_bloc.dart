// ignore_for_file: unnecessary_null_comparison, unrelated_type_equality_checks
import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_app_best_shipp/Shared/models/auth/tag_key/event_param_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../Shared/models/auth/auth_models.dart';
import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/order_scan/order_scan_list_shop.dart';
import '../../../Shared/models/status/status_models.dart';
import '../../../Shared/preferences/preferences.dart';
import '../../../presentation/repositories/order/order_respository.dart';
import '../../../presentation/repositories/user/user_repository.dart';
import 'order_process_event.dart';
import 'order_process_state.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class OrderProcessBloc extends Bloc<OrderProcessEvent, OrderProcessState> {
  final OrderRespository _orderRespository;
  final UserRepository _userRepository;

  OrderProcessBloc(
      {required OrderRespository orderRespository,
      required UserRepository userRepository})
      : assert(orderRespository != null, userRepository != null),
        _orderRespository = orderRespository,
        _userRepository = userRepository,
        super(const OrderProcessState()) {
    int page = 1;
    on<OrderProcessEvent>(
      (event, emit) async {
        String? name = Prefer.prefs?.getString('authenticationViewModel');
        final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
        OrderScanListShopModels orderListShop = OrderScanListShopModels();
        List<OrderModels> data = [];
        OrderListModels lstData = OrderListModels();
        List<OrderModels> lstFirstData = [];
        List<int> number = [];
        StatusData actionStatus = StatusData();
        StatusModels statusModels = StatusModels();
        var isFirstCheck = false;
        // set m???c ?????nh tr???ng th??i cho isfirstload l?? true -> l???n ?????u load data
        var isFirstLoad = true;
        isFirstLoad = state.isFistLoaded;
        // set l???i tr???ng th??i first load theo tr???ng th??i c???a state tr??? v???
        lstFirstData = state.lstData;
        // Ng??y
        EventDate eventDate = EventDate();
        eventDate.startDate = state.eventDate?.startDate ??
            DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year,
                DateTime.now().month - 1, DateTime.now().day));
        eventDate.endDate = state.eventDate?.endDate ??
            DateFormat('yyyy-MM-dd').format(DateTime.now());
        // shop id
        EventShopId eventShopId = EventShopId();
        eventShopId.shopId = state.eventShopId?.shopId ?? 0;
        // list status
        EventListStatus eventListStatus = EventListStatus();
        eventListStatus.orderStatus = state.eventListStatus?.orderStatus ?? [];
        // sort
        EventSorts eventSorts = EventSorts();
        eventSorts.SortType = state.eventSorts?.SortType ?? "";
        // text fields
        EventTextFieldSearch eventTextFields = EventTextFieldSearch();
        eventTextFields.customerName =
            state.eventTextFields?.customerName ?? "";
        eventTextFields.orderCode = state.eventTextFields?.orderCode ?? "";
        eventTextFields.shopOrderCode =
            state.eventTextFields?.shopOrderCode ?? "";
        //phone
        EventTextFieldPhone eventTextFieldPhone = EventTextFieldPhone();
        eventTextFieldPhone.customerPhone =
            state.eventTextFieldPhone?.customerPhone ?? "";

        if (event is OrderProcessStartedEvent) {
          try {
            if (state.status != OrderProcessStatus.initial) {}
            orderListShop = await _orderRespository.getDataListShop('');
          } catch (_) {
            emit(state.copyWith(status: OrderProcessStatus.failure));
          }
        } else if (event is OrderProcessKeyEvent) {
          orderListShop = await _orderRespository.getDataListShop(event.key);
        } else if (event is OrderProcessFilterDateEvent) {
          // check tr???ng th??i c???a isfirtload th??ng qua tr???ng th??i c???a state != tr???ng th??i event truy???n
          //v??o th?? set l???i isfirstload = true
          isFirstLoad =
              ((eventDate != event.startDate) || (eventDate != event.endDate))
                  ? true
                  : false;
          eventDate =
              EventDate(startDate: event.startDate, endDate: event.endDate);
        } else if (event is OrderProcessFilterShopIdEvent) {
          // check tr???ng th??i c???a isfirtload th??ng qua tr???ng th??i c???a state != tr???ng th??i event truy???n
          //v??o th?? set l???i isfirstload = true
          isFirstLoad = eventShopId != event.shopId ? true : false;
          eventShopId = EventShopId(shopId: event.shopId);
        } else if (event is OrderProcessFilterStatusEvent) {
          // check tr???ng th??i c???a isfirtload th??ng qua tr???ng th??i c???a state != tr???ng th??i event truy???n
          //v??o th?? set l???i isfirstload = true
          isFirstLoad = eventListStatus != event.orderStatus ? true : false;
          eventListStatus = EventListStatus(orderStatus: event.orderStatus);
          // set l???i number ????? tr??? v??? state
          number = event.orderStatus!;
        } else if (event is OrderProcessFilterSortEvent) {
          // check tr???ng th??i c???a isfirtload th??ng qua tr???ng th??i c???a state != tr???ng th??i event truy???n
          //v??o th?? set l???i isfirstload = true
          isFirstLoad = eventSorts != event.SortType ? true : false;
          eventSorts = EventSorts(SortType: event.SortType);
        } else if (event is OrderProcessFilterPhoneEvent) {
          // check tr???ng th??i c???a isfirtload th??ng qua tr???ng th??i c???a state != tr???ng th??i event truy???n
          //v??o th?? set l???i isfirstload = true
          isFirstLoad = eventTextFieldPhone.customerPhone != event.customerPhone
              ? true
              : false;
          eventTextFieldPhone =
              EventTextFieldPhone(customerPhone: event.customerPhone);
        } else if (event is OrderProcessFilterTextFieldEvent) {
          // check tr???ng th??i c???a isfirtload th??ng qua tr???ng th??i c???a state != tr???ng th??i event truy???n
          //v??o th?? set l???i isfirstload = true
          isFirstLoad = ((eventTextFields.customerName != event.customerName) ||
                  (eventTextFields.orderCode != event.orderCode) ||
                  (eventTextFields.shopOrderCode != event.shopOrderCode))
              ? true
              : false;
          eventTextFields = EventTextFieldSearch(
              customerName: event.customerName,
              orderCode: event.orderCode,
              shopOrderCode: event.shopOrderCode);
        }
        // event load l???i danh s??ch
        else if (event is OrderProcessFilterEvent) {
          // set tr???ng th??i c???a isfirst load v??? false
          isFirstLoad =
              ((eventDate != event.startDate) || (eventDate != event.endDate))
                  ? true
                  : false;
          try {
            if (state.status != OrderProcessStatus.initial) {
              eventDate =
                  EventDate(startDate: event.startDate, endDate: event.endDate);
              eventShopId = EventShopId(shopId: event.shopId);
              eventListStatus = EventListStatus(orderStatus: event.orderStatus);
              eventSorts = EventSorts(SortType: event.SortType);
              eventTextFieldPhone =
                  EventTextFieldPhone(customerPhone: event.customerPhone);
              eventTextFields = EventTextFieldSearch(
                  customerName: event.customerName,
                  orderCode: event.orderCode,
                  shopOrderCode: event.shopOrderCode);
              isFirstCheck = event.isCheck!;
            }
          } catch (_) {
            emit(state.copyWith(status: OrderProcessStatus.failure));
          }
        }
        // s??? ki???n chuy???n tr???ng th??i th??nh c??ng
        else if (event is OrderProcessSuccessEvent) {
          // set tr???ng th??i c???a isfirst load v??? true
          isFirstLoad = true;
          // l???y data cho tr???ng th??i ????n h??ng sau khi th???c hi???n chuy???n tr???ng th??i th??nh c??ng
          statusModels = await _orderRespository.getDataSuccess(
              event.shopId!, event.code!, event.shipper!);
          actionStatus = statusModels.data!;
          if (statusModels.success != true) {
            OrderProcessStatus.initial;
          } else {
            emit(state.copyWith(status: OrderProcessStatus.failure));
          }
        }
        // s??? ki???n b??o h???y ????n
        else if (event is OrderProcessCancelEvent) {
          // set tr???ng th??i c???a isfirst load v??? true
          isFirstLoad = true;
          // l???y data cho tr???ng th??i ????n h??ng sau khi th???c hi???n b??o h???y
          statusModels = await _orderRespository.getDataCancel(
              event.shopId!,
              event.code!,
              event.shipper!,
              event.CancelId!,
              event.cancelReason!);
          actionStatus = statusModels.data!;
          if (statusModels.success != true) {
            OrderProcessStatus.initial;
          } else {
            emit(state.copyWith(status: OrderProcessStatus.failure));
          }
        }
        // 3 action tr???ng th??i (k b???t m??y, thu?? bao, kh??ch h???n giao)
        else if (event is OrderProcessChangeActionEvent) {
          // set tr???ng th??i c???a isfirst load v??? true
          isFirstLoad = true;
          // l???y data cho tr???ng th??i ????n h??ng 3 action tr???ng th??i (k b???t m??y, thu?? bao, kh??ch h???n giao)
          // l???y data cho tr???ng th??i ????n h??ng sau khi th???c hi???n chuy???n tr???ng th??i
          statusModels = await _orderRespository.getDataAction(
              event.shopId!,
              event.code!,
              event.action_item_id!,
              event.action_call_time!,
              event.shipper!,
              event.action_id!,
              event.action_text!);
          actionStatus = statusModels.data!;
          if (statusModels.success != true) {
            OrderProcessStatus.initial;
          } else {
            emit(state.copyWith(status: OrderProcessStatus.failure));
          }
        }
        // check tr???ng th??i kh??c event OrderProcessKeyEvent
        if (event is! OrderProcessKeyEvent) {
          page = page + 1;
          if (isFirstLoad) {
            page = 1;
            lstFirstData = [];
          }
          isFirstLoad = false;
        }
        // set l???i page
        var indexPage = page;
        // l???y d??? li???u cho list data -> tr???ng th??i userType == 4 s??? chuy???n sang m??n h??nh x??? l?? d??nh ri??ng cho shipper
        lstData = username.userType == 4
            ? await _orderRespository.orderProcessData(
                page,
                eventTextFieldPhone.customerPhone,
                eventTextFields.customerName,
                eventTextFields.orderCode,
                eventTextFields.shopOrderCode,
                eventSorts.SortType)
            : await _orderRespository.filterEvent(
                indexPage,
                eventDate.startDate,
                eventDate.endDate,
                eventTextFieldPhone.customerPhone,
                eventTextFields.customerName,
                eventTextFields.orderCode,
                eventTextFields.shopOrderCode,
                eventSorts.SortType,
                eventShopId.shopId,
                eventListStatus.orderStatus);
        // n???u k c?? data -> tr??? r???ng
        var dataJson = lstData.data ?? [];
        data = event is OrderProcessKeyEvent ? data : List.of(lstFirstData)
          ..addAll(dataJson);
        emit(state.copyWith(
            status: OrderProcessStatus.success,
            lstData: data,
            total: lstData.total,
            total_other: lstData.totalOther,
            total_processing: lstData.totalProcessing,
            total_succsess: lstData.totalSuccsess,
            data: lstData,
            dataListShop: orderListShop.data,
            isFistLoaded: isFirstLoad,
            eventDate: EventDate(
                startDate: eventDate.startDate, endDate: eventDate.endDate),
            eventShopId: EventShopId(shopId: eventShopId.shopId),
            eventListStatus:
                EventListStatus(orderStatus: eventListStatus.orderStatus),
            eventSorts: EventSorts(SortType: eventSorts.SortType),
            eventTextFields: EventTextFieldSearch(
                customerName: eventTextFields.customerName,
                orderCode: eventTextFields.orderCode,
                shopOrderCode: eventTextFields.shopOrderCode),
            eventTextFieldPhone: EventTextFieldPhone(
                customerPhone: eventTextFieldPhone.customerPhone),
            number: number,
            isCheck: isFirstCheck,
            actionStatus: actionStatus,
            isCheckStatus: statusModels.success));
      },
      transformer: throttleDroppable(throttleDuration),
    );
  }
}
