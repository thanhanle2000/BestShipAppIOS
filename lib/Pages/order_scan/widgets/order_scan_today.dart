import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/bloc/order_scan_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/widgets/order_scan_button_filter.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/widgets/order_scan_cod_total.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/widgets/order_scan_total.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/order/order_respository.dart';
import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/models/auth/auth_models.dart';
import '../../../Shared/models/order_scan/order_scan_total.dart';
import '../../../Shared/preferences/preferences.dart';
import '../../../Shared/utils/app_utils.dart';
import '../../../Shared/widgets/base_widget/snackbar_message.dart';
import '../../order_list/order_list_screen.dart';
import '../bloc/order_scan_bloc_event.dart';

class OrderScanToday extends StatelessWidget {
  final DataTotalScan dataTotalScan;
  final OrderScanBloc orderScanBloc;
  final int shopId;
  final String date;
  const OrderScanToday(
      {super.key,
      required this.dataTotalScan,
      required this.orderScanBloc,
      required this.shopId,
      required this.date});
  @override
  Widget build(BuildContext context) {
    String? name = Prefer.prefs?.getString('authenticationViewModel');
    final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
    return Column(children: [
      OrderScanButtonFilter(
          title: 'Hôm nay',
          icon: Icons.refresh_outlined,
          onpress: () async {
            if (shopId != 0) {
              await totalScan(date, shopId);
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  snackBar_message("Vui lòng chọn shop.", "warning"),
                );
            }
          }),
      OrderScanTotal(
          color: Colours.textDefault,
          title: 'Chờ lấy hàng:',
          total: dataTotalScan.orderTotal ?? 0),
      Container(
          color: Colors.white,
          height: 40,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            OrderScanTotal(
                color: fromHexColor(Constants.COLOR_BUTTON),
                title: 'Đã quét mã:',
                total: dataTotalScan.orderTotalPickuped ?? 0),
            Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('COD: ',
                          style: TextStyle(
                              fontSize: 16, color: Colours.textDefault)),
                      Text(format_price(dataTotalScan.totalCODPickuped ?? 0),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colours.textDefault,
                              fontWeight: FontWeight.bold))
                    ]))
          ])),
      OrderScanCodTotal(
          color: fromHexColor(Constants.COLOR_BUTTON), data: dataTotalScan),
      GestureDetector(
          onTap: username.userType == 4
              ? () {}
              : () {
                  if (shopId != 0) {
                    if (dataTotalScan.orderTotalRemain != 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderListScreen(
                                    title: 'Đơn chưa quét',
                                    totalOrder: dataTotalScan.orderTotalRemain!,
                                    repository: OrderRespository(
                                        ShopId: shopId, dateNow: date),
                                  )));
                    } else {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          snackBar_message("Không có dữ liệu.", "warning"),
                        );
                    }
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        snackBar_message("Vui lòng chọn shop.", "warning"),
                      );
                  }
                },
          child: OrderScanTotal(
              color: Colours.textDefault,
              title: 'Đơn còn lại:',
              total: dataTotalScan.orderTotalRemain ?? 0)),
    ]);
  }

  // Hàm lấy total scan
  // ignore: body_might_complete_normally_nullable
  Future<void>? totalScan(String date, int shopId) {
    orderScanBloc.add(OrderScanBlocTotalScanEvent(date: date, shopId: shopId));
  }
}
