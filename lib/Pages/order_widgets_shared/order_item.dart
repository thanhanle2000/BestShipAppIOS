import 'package:flutter/material.dart';
import '../../Shared/models/order_list/order_list_models.dart';
import 'order_item_customer.dart';
import 'order_item_payment.dart';
import 'order_item_status_action.dart';

class OrderShareItem extends StatefulWidget {
  final bool isActiveStatus;
  final OrderModels data;
  const OrderShareItem(
      {super.key, required this.data, this.isActiveStatus = false});

  @override
  State<OrderShareItem> createState() => _OrderShareItemState();
}

class _OrderShareItemState extends State<OrderShareItem> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    var item = widget.data;
    return GestureDetector(
        onTap: () {
          setState(() {
            isCheck = !isCheck;
          });
        },
        child: Container(
            margin: const EdgeInsets.only(top: 3),
            padding: const EdgeInsets.all(5),
            color: Colors.white,
            child: Column(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                OrderItemCustomer(data: item),
                isCheck == true
                    ? OrderItemPayment(data: item)
                    : const SizedBox(),
                !widget.isActiveStatus
                    ? OrderItemStatusAction(data: item)
                    : const SizedBox()
              ])
            ])));
  }
}
