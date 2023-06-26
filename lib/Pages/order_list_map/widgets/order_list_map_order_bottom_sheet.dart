import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/blocs/theme/color.dart';
import 'package:intl/intl.dart';
import '../../../Pages/order_list_map/bloc/map_bloc.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/status/status_models.dart';
import '../../../Shared/utils/app_utils.dart';
import '../../order_widgets_shared/order_item.dart';
import 'order_list_map_button_status.dart';
import '../../../Pages/order_list_map/widgets/order_list_map_status/order_list_map_status_appointment.dart';
import '../../../Pages/order_list_map/widgets/order_list_map_status/order_list_map_status_cancel.dart';
import '../../../Pages/order_list_map/widgets/order_list_map_status/order_list_map_status_phone_no_pick.dart';
import '../../../Pages/order_list_map/widgets/order_list_map_status/order_list_map_status_phone_sub.dart';
import '../../../Pages/order_list_map/widgets/order_list_map_status/order_list_map_status_success.dart';

class OrderListMapInfoOrder extends StatefulWidget {
  final OrderModels data;
  final StatusData status;
  final MapBloc mapBloc;
  final BuildContext contextMain;

  const OrderListMapInfoOrder(
      {super.key,
      required this.data,
      required this.status,
      required this.mapBloc,
      required this.contextMain});

  @override
  State<OrderListMapInfoOrder> createState() => _OrderListMapInfoOrderState();
}

class _OrderListMapInfoOrderState extends State<OrderListMapInfoOrder> {
  bool isActive = false;
  bool isChange = true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: OrderShareItem(data: widget.data, isActiveStatus: true)),
      // OderItem_Shop(data: widget.data),
      widget.data.baseStatus!.status == 4
          ? Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OrderListMapButtonStatus(
                            title: 'Thành công',
                            onTap: () async {
                              await showdiasuccess(widget.data, widget.status);
                            },
                            hw: 35,
                            color: fromHexColor(Constants.COLOR_BUTTON)),
                        OrderListMapButtonStatus(
                            title: 'Báo hủy đơn',
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderListMapStatusCancel(
                                          data: widget.data,
                                          status: widget.status,
                                          mapBloc: widget.mapBloc,
                                          contextBloc: widget.contextMain,
                                        ))),
                            hw: 35,
                            color: Colors.red.shade700)
                      ]),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OrderListMapButtonStatus(
                            title: 'Không bắt máy',
                            onTap: () async {
                              await showdiaphonenopick(
                                  widget.data, widget.status);
                            },
                            hw: 5,
                            color: fromHexColor(Constants.COLOR_APPBAR)),
                        OrderListMapButtonStatus(
                            title: 'Thuê bao',
                            onTap: () async {
                              await showdiaphonesub(widget.data, widget.status);
                            },
                            hw: 15,
                            color: fromHexColor(Constants.COLOR_APPBAR)),
                        OrderListMapButtonStatus(
                            title: 'Lí do khác',
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderListMapStatusAppointment(
                                          data: widget.data,
                                          status: widget.status,
                                          mapBloc: widget.mapBloc,
                                          contextBloc: widget.contextMain,
                                        ))),
                            hw: 10,
                            color: fromHexColor(Constants.COLOR_APPBAR))
                      ]),
                  const SizedBox(height: 10),
                  Column(
                      children:
                          buildListStatusHisV2(widget.data.ordersStatusHistory))
                ],
              ))
          : const SizedBox()
    ]);
  }

  // hiển thị dữ liệu cho bottomsheet xử lí tác vụ đơn hàng
  List<Widget> buildListStatusHisV2(List<OrdersStatusHistory>? lstStatusHis) {
    List<Widget> lstWidget = [];
    if (lstStatusHis == null) {
      return lstWidget;
    }

    var data = isActive ? lstStatusHis : lstStatusHis.take(2);
    data.map((item) {
      lstWidget.add(item.action_text == null
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Expanded(
                      child: Wrap(children: [
                    Text('${item.action_text}',
                        style: const TextStyle(
                            fontSize: 15, color: Colours.textDefault))
                  ])),
                  const SizedBox(width: 0.7),
                  Text(
                      DateFormat("HH:mm dd-MM-yyyy")
                          .format(DateTime.parse(item.rowCreatedTime!)),
                      style: const TextStyle(
                          fontSize: 12, color: Colours.textDefault))
                ]));
    }).toList();

    if (!isActive && lstStatusHis.length > 2) {
      lstWidget.add(TextButton(
          onPressed: () {
            setState(() {
              isActive = isChange;
            });
          },
          child: const Text('Xem thêm...',
              style: TextStyle(fontSize: 15, color: Colors.blue))));
    }
    return lstWidget;
  }

  // chuyển đổi trạng thái thành công
  Future<void> showdiasuccess(OrderModels data, StatusData status) async {
    await showDialog(
        context: widget.contextMain,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              actions: [
                OrderListMapStatusSuccess(
                  data: data,
                  status: status,
                  mapBloc: widget.mapBloc,
                  contextBloc: widget.contextMain,
                )
              ]);
        });
  }

  // chuyển đổi trạng thái đơn không bắt máy
  Future<void> showdiaphonenopick(OrderModels data, StatusData status) async {
    await showDialog(
        context: widget.contextMain,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              actions: [
                OrderListMapStatusPhoneNoPick(
                  data: data,
                  status: status,
                  mapBloc: widget.mapBloc,
                  contextBloc: widget.contextMain,
                )
              ]);
        });
  }

  // chuyển đổi trạng thái đơn thuê bao
  Future<void> showdiaphonesub(OrderModels data, StatusData status) async {
    await showDialog(
        context: widget.contextMain,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              actions: [
                OrderListMapStatusPhoneSubscriber(
                  data: data,
                  status: status,
                  mapBloc: widget.mapBloc,
                  contextBloc: widget.contextMain,
                )
              ]);
        });
  }
}
