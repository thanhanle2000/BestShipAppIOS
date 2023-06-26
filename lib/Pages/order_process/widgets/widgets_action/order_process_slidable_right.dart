import 'package:flutter/material.dart';
import '../../../../Shared/constants/constants.dart';
import '../../../../Shared/models/order_list/order_list_models.dart';
import '../../../../Shared/models/status/status_models.dart';
import '../../../../Shared/utils/app_utils.dart';
import '../../bloc/order_process_bloc.dart';
import 'order_process_action_appointment.dart';
import 'order_process_action_cir.dart';
import 'order_process_action_phone_no_pick.dart';
import 'order_process_action_phone_sub.dart';

class OrderProcessSidableRight extends StatelessWidget {
  final OrderProcessBloc orderBloc;
  final BuildContext blocContext;
  final OrderModels data;
  final StatusData status;
  final int userType;
  const OrderProcessSidableRight(
      {super.key,
      required this.orderBloc,
      required this.blocContext,
      required this.data,
      required this.status,
      required this.userType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Column(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: OrderProcessActionCir(
                      lr: 5,
                      onTap: () => showdiaphonenopick(data, status),
                      title: 'Không bắt máy',
                      color: fromHexColor(Constants.COLOR_APPBAR),
                      iconData: Icons.phone_missed_outlined))),
          Expanded(
            flex: 1,
            child: OrderProcessActionCir(
              lr: 28,
              onTap: () => showdiaphonesub(data, status),
              title: 'Thuê bao',
              color: fromHexColor(Constants.COLOR_APPBAR),
              iconData: Icons.phone_locked_outlined,
            ),
          )
        ],
      ),
      SizedBox(
          child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: SizedBox(
                  child: OrderProcessActionCir(
                      lr: 5,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OrderProcessActionAppointment(
                                    data: data,
                                    status: status,
                                    orderBloc: orderBloc,
                                    contextBloc: blocContext,
                                    userType: userType,
                                  ))),
                      title: 'Lí do khác',
                      color: fromHexColor(Constants.COLOR_APPBAR),
                      iconData: Icons.assignment_late_rounded))))
    ]));
  }

  // chuyển đổi trạng thái đơn không bắt máy
  Future<void> showdiaphonenopick(OrderModels data, StatusData status) async {
    await showDialog(
        context: blocContext,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              actions: [
                OrderProcessActionPhoneNoPick(
                  data: data,
                  status: status,
                  mapBloc: orderBloc,
                  contextBloc: blocContext,
                )
              ]);
        });
  }

  // chuyển đổi trạng thái đơn thuê bao
  Future<void> showdiaphonesub(OrderModels data, StatusData status) async {
    await showDialog(
        context: blocContext,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              actions: [
                OrderProcessActionPhoneSubscriber(
                  data: data,
                  status: status,
                  mapBloc: orderBloc,
                  contextBloc: blocContext,
                )
              ]);
        });
  }
}
