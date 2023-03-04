import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(children: [
        const SizedBox(height: 5),
        !IsNullOrEmpty(widget.data.orderStatusNote!)
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(Icons.comment,
                    color: fromHexColor(Constants.COLOR_APPBAR), size: 15),
                const SizedBox(width: 5),
                Expanded(
                    child: Wrap(children: [
                  Text(widget.data.orderStatusNote!,
                      style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline))
                ]))
              ])
            : const SizedBox(),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          OrderShareColorStatus(baseStatus: widget.data.baseStatus!),
        ])
      ]),
    );
  }
}
