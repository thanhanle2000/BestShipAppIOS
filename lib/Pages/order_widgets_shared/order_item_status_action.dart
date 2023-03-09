import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Shared/blocs/theme/color.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/models/order_list/order_list_models.dart';
import '../../Shared/utils/app_utils.dart';
import 'order_item_statusColor.dart';

// widget use status & action
// ignore: camel_case_types
class OrderItemStatusAction extends StatefulWidget {
  final OrderModels data;
  const OrderItemStatusAction({super.key, required this.data});

  @override
  State<OrderItemStatusAction> createState() => OrderItemStatusActionState();
}

// ignore: camel_case_types
class OrderItemStatusActionState extends State<OrderItemStatusAction> {
  var date = 0;
  var hour = 0;
  var min = 0;
  @override
  void initState() {
    super.initState();
    // dd-MM-yyyy - HH:mm
    Duration diff =
        DateTime.now().difference(DateTime.parse(widget.data.rowCreatedTime!));
    //
    date = diff.inDays;
    //
    hour = diff.inHours;
    //
    min = diff.inMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Column(children: [
          const SizedBox(height: 3),
          !IsNullOrEmpty(widget.data.orderStatusNote!)
              ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(Icons.comment,
                      color: fromHexColor(Constants.COLOR_APPBAR), size: 14),
                  const SizedBox(width: 5),
                  Expanded(
                      child: Wrap(children: [
                    Text(widget.data.orderStatusNote!,
                        style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline))
                  ]))
                ])
              : const SizedBox(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            widget.data.baseStatus?.status == 4
                ? Row(children: [
                    Icon(Icons.update,
                        color: fromHexColor(Constants.COLOR_APPBAR), size: 14),
                    const SizedBox(width: 3),
                    Text(
                        date > 0
                            ? '${date.toString()} ngày'
                            : (min < 60
                                ? '${min.toString()} phút'
                                : '${hour.toString()} giờ'),
                        style: const TextStyle(
                            fontSize: 14, color: Colours.textDefault))
                  ])
                : const SizedBox(),
            OrderShareColorStatus(baseStatus: widget.data.baseStatus!)
          ])
        ]));
  }
}
