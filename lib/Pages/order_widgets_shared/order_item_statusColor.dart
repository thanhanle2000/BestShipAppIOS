import 'package:flutter/material.dart';
import '../../Shared/models/order_list/order_list_models.dart';

class OrderShareColorStatus extends StatelessWidget {
  final BaseStatus baseStatus;
  const OrderShareColorStatus({super.key, required this.baseStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Status_Color(baseStatus.status!),
            border: Border.all(
              color: Status_Color(baseStatus.status!)!,
            )),
        child: Text(baseStatus.name!,
            style: const TextStyle(fontSize: 14, color: Colors.white)));
  }

  // ignore: missing_return, non_constant_identifier_names
  Color? Status_Color(int status) {
    if (status == 1) {
      return Colors.blue;
    } else if (status == 2) {
      return Colors.orange;
    } else if (status == 3) {
      return Colors.yellow;
    } else if (status == 4) {
      return Colors.purple;
    } else if (status == 5) {
      return Colors.green;
    } else if (status == 6) {
      return Colors.red;
    } else if (status == 7) {
      return Colors.yellowAccent;
    } else if (status == 8) {
      return Colors.amberAccent;
    }
  }
}
