import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_event.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Shared/constants/constants.dart';
import '../../../../Shared/models/auth/tag_key/tagkeyword.dart';
import '../../../../Shared/models/order_list/order_list_models.dart';
import '../../../../Shared/models/status/status_models.dart';
import '../../../../Shared/utils/app_utils.dart';
import '../../../../Shared/utils/get_call_log.dart';
import '../../../order_list_map/widgets/order_list_button_confirm_filter.dart';
import '../../../order_list_map/widgets/order_list_map_status/order_list_map_status_appbar.dart';
import '../../../order_list_map/widgets/order_list_map_status/order_list_map_status_textfield.dart';
import '../../../order_widgets_shared/order_item_customer.dart';

class OrderProcessActionAppointment extends StatefulWidget {
  final OrderModels data;
  final StatusData status;
  final OrderProcessBloc orderBloc;
  final BuildContext contextBloc;
  final int userType;

  const OrderProcessActionAppointment(
      {super.key,
      required this.data,
      required this.status,
      required this.orderBloc,
      required this.contextBloc,
      required this.userType});

  @override
  State<OrderProcessActionAppointment> createState() =>
      _OrderProcessActionAppointmentState();
}

class _OrderProcessActionAppointmentState
    extends State<OrderProcessActionAppointment> {
  String item = 'Mời nhập vào lí do';
  int _currentTimeValue = 1;
  int CancelId = 1;
  int action_call_time = 0;
  TextEditingController _controllerAppointment = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadCallLogs();
    calllog();

    // Đăng ký callback để cập nhật dữ liệu khi có sự thay đổi trong cuộc gọi
    final OrderItemCustomerState? orderItemCustomerState =
        context.findAncestorStateOfType<OrderItemCustomerState>();
    orderItemCustomerState?.setOnCallLogChangedCallback(() {
      // Cập nhật dữ liệu cuộc gọi khi có sự thay đổi
      loadCallLogs();
    });
  }

  void loadCallLogs() async {
    if (widget.data != null) {
      action_call_time = await getCallLogs(widget.data.id!);
      print("#####################");
      print(action_call_time);
      calllog();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: OrderListMapStatusAppbar(title: 'Lí do khác')),
        body: Form(
            key: _formKey,
            child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: actionItem
                            .map((e) => RadioListTile<int>(
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(2, 8, 2, 0),
                                  groupValue: _currentTimeValue,
                                  title: Text(e.action_item_text),
                                  value: e.action_item_id,
                                  onChanged: (val) {
                                    setState(() {
                                      _currentTimeValue = val!;
                                      CancelId = e.action_item_id;
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      CancelId == 100
                          ? OrderListStatusTextFields(
                              title: item,
                              validator: (value) {
                                return IsNullOrEmpty(value!)
                                    ? 'Vui lòng nhập vào lí do khác'
                                    : null;
                              },
                              controller: _controllerAppointment,
                            )
                          : const SizedBox(),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OrderListButtonConfirmFilter(
                                onpress: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await onActionOrther(
                                        widget.data.shopId!,
                                        widget.data.orderCode!,
                                        widget.data.shipper!,
                                        _controllerAppointment.text,
                                        widget.status,
                                        widget.contextBloc);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  }
                                },
                                title: 'Xác nhận',
                                color: fromHexColor(Constants.COLOR_BUTTON),
                                hw: 25),
                            OrderListButtonConfirmFilter(
                                onpress: () async => Navigator.pop(context),
                                title: 'Đóng',
                                color: fromHexColor(Constants.COLOR_APPBAR),
                                hw: 20)
                          ])
                    ]))));
  }

  // danh sách lý do
  List<ActionItemModel> actionItem = [
    ActionItemModel(
        action_item_id: 2,
        action_item_text: 'Khách hẹn lại thời gian nhận hàng'),
    ActionItemModel(action_item_id: 4, action_item_text: 'SĐT không đúng'),
    ActionItemModel(action_item_id: 5, action_item_text: 'Địa chỉ không đúng'),
    ActionItemModel(action_item_id: 100, action_item_text: 'Lí do khác'),
  ];

  // kiểm tra cấp quyền chuyển cuộc gọi
  void calllog() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    for (var item in entries) {}

    // ignore: unused_element
    Future<void> getPermissionUser() async {
      if (await Permission.phone.request().isGranted) {
        calllog();
      } else {
        await Permission.phone.request();
      }
    }
  }

  // hàm xử lí chuyển trạng thái lý do khác
  // ignore: body_might_complete_normally_nullable
  Future<void>? onActionOrther(int shopId, String code, String shipper,
      String action_text, StatusData status, BuildContext context) {
    widget.orderBloc.add(OrderProcessChangeActionEvent(
        shopId: shopId,
        code: code,
        action_item_id: CancelId,
        action_call_time: action_call_time,
        shipper: shipper,
        action_id: 3,
        action_text: action_text,
        statusModels: status,
        blocContext: context,
        processBloc: widget.orderBloc));
  }
}
