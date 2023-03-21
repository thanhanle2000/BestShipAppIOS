import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_event.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../Shared/constants/constants.dart';
import '../../../../Shared/models/auth/tag_key/tagkeyword.dart';
import '../../../../Shared/models/order_list/order_list_models.dart';
import '../../../../Shared/models/status/status_models.dart';
import '../../../../Shared/utils/app_utils.dart';
import '../../../order_list_map/widgets/order_list_button_confirm_filter.dart';
import '../../../order_list_map/widgets/order_list_map_status/order_list_map_status_appbar.dart';
import '../../../order_list_map/widgets/order_list_map_status/order_list_map_status_textfield.dart';

class OrderProcessActionAppointment extends StatefulWidget {
  final OrderModels data;
  final StatusData status;
  final OrderProcessBloc orderBloc;
  final BuildContext contextBloc;

  const OrderProcessActionAppointment(
      {super.key,
      required this.data,
      required this.status,
      required this.orderBloc,
      required this.contextBloc});

  @override
  State<OrderProcessActionAppointment> createState() =>
      _OrderProcessActionAppointmentState();
}

class _OrderProcessActionAppointmentState
    extends State<OrderProcessActionAppointment> {
  String item = 'Mời nhập vào lí do';
  int _currentTimeValue = 1;
  int CancelId = 1;
  TextEditingController _controllerAppointment = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    calllog();
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
                                  // ignore: prefer_const_constructors
                                  visualDensity: VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity),
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
    ActionItemModel(action_item_id: 1, action_item_text: 'Khách báo bận'),
    ActionItemModel(
        action_item_id: 2, action_item_text: 'Khách hẹn lại ngày khác'),
    ActionItemModel(
        action_item_id: 3,
        action_item_text: 'Khách hàng đi vắng, không có ở nhà'),
    ActionItemModel(
        action_item_id: 4, action_item_text: 'Khách hàng hẹn buổi sáng'),
    ActionItemModel(
        action_item_id: 5, action_item_text: 'Khách hàng hẹn buổi chiều'),
    ActionItemModel(
        action_item_id: 6,
        action_item_text: 'Khách hàng hẹn giao giờ hành chính'),
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

  // hàm xử lí chuyển trạng thái không bắt máy
  // ignore: body_might_complete_normally_nullable
  Future<void>? onActionOrther(int shopId, String code, String shipper,
      String action_text, StatusData status, BuildContext context) {
    widget.orderBloc.add(OrderProcessChangeActionEvent(
        shopId: shopId,
        code: code,
        action_item_id: CancelId,
        action_call_time: 0,
        shipper: shipper,
        action_id: 3,
        action_text: action_text,
        statusModels: status,
        blocContext: context,
        processBloc: widget.orderBloc));
  }

  void showNoti(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
        elevation: 0,
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 5),
        content: Text(text, style: const TextStyle(fontSize: 16))));
  }
}
