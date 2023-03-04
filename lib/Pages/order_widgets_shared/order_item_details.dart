import 'package:flutter/material.dart';
import '../../Shared/models/order_list/order_list_models.dart';
import '../../Shared/widgets/base_widget/endData.dart';
import 'order_item.dart';

class OrderItemDetails extends StatefulWidget {
  final List<OrderModels> orderModel;
  const OrderItemDetails({super.key, required this.orderModel});

  @override
  State<OrderItemDetails> createState() => _OrderItemDetailsState();
}

class _OrderItemDetailsState extends State<OrderItemDetails> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.orderModel.length + 1,
        itemBuilder: (c, i) {
          if (i < widget.orderModel.length) {
            return OrderShareItem(
              data: widget.orderModel[i],
              isActiveStatus: false,
            );
          } else {
            // ignore: unnecessary_null_comparison
            if (widget.orderModel == null) {
              return const SizedBox();
            } else {
              return endData();
            }
          }
        });
  }
}
