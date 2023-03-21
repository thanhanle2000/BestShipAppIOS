import 'package:flutter/material.dart';
import '../../bloc/map_bloc.dart';
import '../../../../Shared/blocs/theme/color.dart';
import '../../../../Shared/constants/constants.dart';
import '../../../../Shared/models/order_list/order_list_models.dart';
import '../../../../Shared/models/status/status_models.dart';
import '../../../../Shared/utils/app_utils.dart';
import '../order_list_button_confirm_filter.dart';

class OrderListMapStatusPhoneNoPick extends StatelessWidget {
  final OrderModels data;
  final StatusData status;
  final MapBloc mapBloc;
  final BuildContext contextBloc;
  const OrderListMapStatusPhoneNoPick(
      {super.key,
      required this.data,
      required this.status,
      required this.mapBloc,
      required this.contextBloc});
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Column(children: [
      const Text('Điện thoại không bắt máy',
          style: TextStyle(fontSize: 18, color: Colours.textDefault)),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        OrderListButtonConfirmFilter(
            onpress: () async {
              await onAction_PhoneNoPick(data.shopId!, data.orderCode!,
                  data.shipper!, status, contextBloc);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            title: 'Xác nhận',
            color: fromHexColor(Constants.COLOR_BUTTON),
            hw: 10),
        OrderListButtonConfirmFilter(
            onpress: () => Navigator.pop(context),
            title: 'Đóng',
            color: fromHexColor(Constants.COLOR_APPBAR),
            hw: 18)
      ])
    ]);
  }

  // hàm xử lí chuyển trạng thái không bắt máy
  // ignore: non_constant_identifier_names, body_might_complete_normally_nullable
  Future<void>? onAction_PhoneNoPick(int shopId, String code, String shipper,
      StatusData status, BuildContext context) {
    mapBloc.add(MapBlocEventChangeActionEvent(
        shopId: shopId,
        code: code,
        action_item_id: 0,
        action_call_time: 0,
        shipper: shipper,
        action_id: 1,
        action_text: '',
        statusModels: status,
        context: context,
        mapBloc: mapBloc));
  }
}
