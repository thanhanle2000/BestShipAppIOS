import 'package:flutter/material.dart';

class OrderListModalBottomSheet extends StatelessWidget {
  final String? title;
  final Widget? UI;
  final bool? HasTitle;
  final double? height;
  const OrderListModalBottomSheet(
      {super.key, this.title, this.UI, this.HasTitle, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
        child: Center(
            child: Column(children: [
          HasTitle!
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(title!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)))
              : const SizedBox(),
          UI!
        ])));
  }
}
