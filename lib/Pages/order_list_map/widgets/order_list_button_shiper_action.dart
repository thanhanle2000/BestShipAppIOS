import 'package:flutter/material.dart';

import '../../../Shared/blocs/theme/color.dart';

// button action use ui order list (không bắt máy, hẹn giao, thuê bao.....)
class OrderListButtonShiperAction extends StatefulWidget {
  final bool isactive;
  final void Function() onpress;
  final String title;
  final IconData icon;
  final Color color;
  const OrderListButtonShiperAction(
      {super.key,
      required this.onpress,
      required this.title,
      required this.icon,
      required this.color,
      required this.isactive});

  @override
  State<OrderListButtonShiperAction> createState() =>
      _OrderListButtonShiperActionState();
}

class _OrderListButtonShiperActionState
    extends State<OrderListButtonShiperAction> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
            onTap: widget.onpress,
            child: Container(
                width: 180,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: widget.isactive == true
                            ? Colours.active_button
                            : Colors.white)),
                child: Row(children: [
                  Icon(widget.icon),
                  const SizedBox(width: 18),
                  Text(widget.title,
                      style: const TextStyle(fontSize: 15, color: Colors.white))
                ]))));
  }
}
