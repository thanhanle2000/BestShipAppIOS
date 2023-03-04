import 'package:flutter/material.dart';

import '../../../Shared/blocs/theme/color.dart';

class OrderListReasonCancel extends StatelessWidget {
  final Function() onTap;
  final int id;
  final String name;
  const OrderListReasonCancel(
      {super.key, required this.id, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.all(5),
            color: Colors.white,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$id',
                      style: const TextStyle(
                          fontSize: 15, color: Colours.textDefault)),
                  const SizedBox(width: 5),
                  Expanded(
                      child: Wrap(children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 15, color: Colours.textDefault))
                  ]))
                ])));
  }
}
