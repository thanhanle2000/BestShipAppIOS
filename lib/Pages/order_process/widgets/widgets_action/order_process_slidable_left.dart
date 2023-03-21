import 'package:flutter/material.dart';
import '../../../../Shared/constants/constants.dart';
import '../../../../Shared/models/order_list/order_list_models.dart';
import '../../../../Shared/models/status/status_models.dart';
import '../../../../Shared/utils/app_utils.dart';
import '../../bloc/order_process_bloc.dart';
import 'order_process_action_cancel.dart';
import 'order_process_action_cir.dart';
import 'order_process_action_success.dart';

class OrderProcessSidableLeft extends StatelessWidget {
  final OrderProcessBloc orderBloc;
  final BuildContext blocContext;
  final OrderModels data;
  final StatusData status;
  const OrderProcessSidableLeft(
      {super.key,
      required this.orderBloc,
      required this.blocContext,
      required this.data,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(children: [
      Expanded(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.all(3),
              child: OrderProcessActionCir(
                  lr: 7,
                  onTap: () {
                    showdiasuccess(data, status);
                  },
                  title: 'Thành công',
                  color: fromHexColor(Constants.COLOR_BUTTON),
                  iconData: Icons.check_rounded))),
      Expanded(
          flex: 1,
          child: OrderProcessActionCir(
              lr: 5,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderProcessActionCancel(
                          data: data,
                          status: status,
                          mapBloc: orderBloc,
                          contextBloc: blocContext))),
              title: 'Báo hủy đơn',
              color: Colors.redAccent,
              iconData: Icons.clear_outlined))
    ]));
  }

  // chuyển đổi trạng thái thành công
  Future<void> showdiasuccess(OrderModels data, StatusData status) async {
    await showDialog(
        context: blocContext,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              actions: [
                OrderProcessActionSuccess(
                    data: data,
                    status: status,
                    mapBloc: orderBloc,
                    contextBloc: blocContext)
              ]);
        });
  }
}
