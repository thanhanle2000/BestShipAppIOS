import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_event.dart';

import '../../../../Shared/constants/constants.dart';
import '../../../../Shared/models/auth/tag_key/tagkeyword.dart';
import '../../../../Shared/models/order_list/order_list_models.dart';
import '../../../../Shared/models/status/status_models.dart';
import '../../../../Shared/utils/app_utils.dart';
import '../../../order_list_map/widgets/order_list_button_confirm_filter.dart';
import '../../../order_list_map/widgets/order_list_map_status/order_list_map_status_appbar.dart';
import '../../../order_list_map/widgets/order_list_map_status/order_list_map_status_textfield.dart';

class OrderProcessActionCancel extends StatefulWidget {
  final OrderModels data;
  final StatusData status;
  final OrderProcessBloc mapBloc;
  final BuildContext contextBloc;

  const OrderProcessActionCancel(
      {super.key,
      required this.data,
      required this.status,
      required this.mapBloc,
      required this.contextBloc});

  @override
  State<OrderProcessActionCancel> createState() =>
      _OrderProcessActionCancelState();
}

class _OrderProcessActionCancelState extends State<OrderProcessActionCancel> {
  String item = 'Mời nhập vào lí do';
  int _currentTimeValue = 1;
  int CancelId = 1;
  TextEditingController _controllerCancel = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: OrderListMapStatusAppbar(title: 'Chuyển trạng thái hủy')),
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: itemListCancel
                    .map((e) => RadioListTile<int>(
                          // ignore: prefer_const_constructors
                          visualDensity: VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          contentPadding: const EdgeInsets.fromLTRB(2, 8, 2, 0),
                          groupValue: _currentTimeValue,
                          title: Text(e.name),
                          value: e.id,
                          onChanged: (val) {
                            setState(() {
                              _currentTimeValue = val!;
                              CancelId = e.id;
                            });
                          },
                        ))
                    .toList(),
              ),
              CancelId == 100
                  ? OrderListStatusTextFields(
                      title: item,
                      controller: _controllerCancel,
                      validator: (value) {
                        return IsNullOrEmpty(value!)
                            ? 'Vui lòng nhập vào lí do hủy'
                            : null;
                      },
                    )
                  : const SizedBox(),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                OrderListButtonConfirmFilter(
                    onpress: () async {
                      if (_formKey.currentState!.validate()) {
                        await onCancel(
                            widget.data.shopId!,
                            widget.data.orderCode!,
                            widget.data.shipper!,
                            CancelId,
                            _controllerCancel.text,
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
                    onpress: () {
                      Navigator.pop(context);
                    },
                    title: 'Đóng',
                    color: fromHexColor(Constants.COLOR_APPBAR),
                    hw: 20)
              ])
            ]),
          ),
        ));
  }

  List<Item> itemListCancel = [
    Item(name: 'Khách hàng không mua nữa', id: 1),
    Item(name: 'Khách hàng từ chối nhận hàng', id: 2),
    Item(name: 'Khách báo hủy', id: 3),
    Item(name: 'Shop hủy', id: 4),
    Item(name: 'Số điện thoại boom hàng', id: 5),
    Item(name: 'Khách đi công tác không nhận được', id: 6),
    Item(name: 'Lí do khác', id: 100),
  ];
  // hàm xử lí chuyển trạng thái hủy
  // ignore: body_might_complete_normally_nullable
  Future<void>? onCancel(int shopId, String code, String shipper, int CancelId,
      String cancelReason, StatusData status, BuildContext context) {
    widget.mapBloc.add(OrderProcessCancelEvent(
        shopId: shopId,
        code: code,
        shipper: shipper,
        CancelId: CancelId,
        cancelReason: cancelReason,
        statusModels: status,
        blocContext: context,
        processBloc: widget.mapBloc));
  }
}
