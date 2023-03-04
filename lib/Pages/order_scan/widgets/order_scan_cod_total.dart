import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/constants/constants.dart';
import 'package:flutter_app_best_shipp/Shared/utils/app_utils.dart';
import 'package:intl/intl.dart';
import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/models/order_scan/order_scan_total.dart';

//lấy giá trị total cho ui scan oder (tổng, đã quét, sót)
class OrderScanCodTotal extends StatelessWidget {
  final DataTotalScan data;
  final Color color;
  const OrderScanCodTotal({super.key, required this.color, required this.data});

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "vi_VN");
    return Container(
      color: Colors.white,
      height: 40,
      padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tổng cước: ',
                  style: TextStyle(fontSize: 16, color: Colours.textDefault)),
              Text(oCcy.format(data.totalShipPickuped ?? 0),
                  style: TextStyle(
                      fontSize: 20,
                      color: fromHexColor(Constants.COLOR_BUTTON),
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Còn lại: ',
                  style: TextStyle(fontSize: 16, color: Colours.textDefault)),
              Text(oCcy.format(data.totalRemainPickuped ?? 0),
                  style: TextStyle(
                      fontSize: 20,
                      color: fromHexColor(Constants.COLOR_APPBAR),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
