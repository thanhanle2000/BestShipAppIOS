import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_event.dart';
import '../../../../Shared/blocs/theme/color.dart';
import '../../../../Shared/constants/constants.dart';
import '../../../../Shared/models/order_list/order_list_models.dart';
import '../../../../Shared/models/status/status_models.dart';
import '../../../../Shared/utils/app_utils.dart';
import '../../../order_list_map/widgets/order_list_button_confirm_filter.dart';

class OrderProcessActionPhoneSubscriber extends StatelessWidget {
  final OrderModels data;
  final StatusData status;
  final OrderProcessBloc mapBloc;
  final BuildContext contextBloc;
  const OrderProcessActionPhoneSubscriber(
      {super.key,
      required this.data,
      required this.status,
      required this.mapBloc,
      required this.contextBloc});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Column(children: [
      const Text('Điện thoại thuê bao',
          style: TextStyle(fontSize: 18, color: Colours.textDefault)),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        OrderListButtonConfirmFilter(
            onpress: () async {
              await onActionPhoneSubscriber(data.shopId!, data.orderCode!,
                  data.shipper!, status, contextBloc);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            title: 'Xác nhận',
            color: fromHexColor(Constants.COLOR_BUTTON),
            hw: 10),
        OrderListButtonConfirmFilter(
            onpress: () {
              Navigator.pop(context);
            },
            title: 'Đóng',
            color: fromHexColor(Constants.COLOR_APPBAR),
            hw: 18)
      ])
    ]);
  }

  // hàm xử lí chuyển trạng thái thuê bao
  // ignore: body_might_complete_normally_nullable
  Future<void>? onActionPhoneSubscriber(int shopId, String code, String shipper,
      StatusData status, BuildContext context) {
    mapBloc.add(OrderProcessChangeActionEvent(
        shopId: shopId,
        code: code,
        action_item_id: 0,
        action_call_time: 0,
        shipper: shipper,
        action_id: 2,
        action_text: '',
        statusModels: status,
        blocContext: context,
        processBloc: mapBloc));
  }
}
