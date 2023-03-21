import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  final String title;
  final Widget ui;
  final bool hasTitle;
  final double height;
  const ModalBottomSheet(
      {super.key,
      required this.title,
      required this.ui,
      required this.hasTitle,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * height,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            )),
        child: Center(
            child: Column(children: [
          hasTitle
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)))
              : const SizedBox(),
          ui
        ])));
  }
}
