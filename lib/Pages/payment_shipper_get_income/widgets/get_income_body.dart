import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/constants/constants.dart';
import 'package:flutter_app_best_shipp/Shared/utils/app_utils.dart';
import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/models/payment/income_models.dart';

class GetIncomeBody extends StatelessWidget {
  final Income data;
  final String title;
  const GetIncomeBody({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Tổng đơn: ',
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            Text('${data.totalOrder ?? 0}',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colours.classicText,
                    fontWeight: FontWeight.bold))
          ]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Đang xử lý: ',
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            Text('${data.totalProcess ?? 0}',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold))
          ]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Thành công: ',
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            Text('${data.totalSuccess ?? 0}',
                style: TextStyle(
                    fontSize: 20,
                    color: fromHexColor(Constants.COLOR_BUTTON),
                    fontWeight: FontWeight.bold))
          ]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Thu nhập: ',
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            Text(format_price(data.receivedPrice ?? 0),
                style: TextStyle(
                    fontSize: 20,
                    color: fromHexColor(Constants.COLOR_APPBAR),
                    fontWeight: FontWeight.bold))
          ])
        ]));
  }
}
