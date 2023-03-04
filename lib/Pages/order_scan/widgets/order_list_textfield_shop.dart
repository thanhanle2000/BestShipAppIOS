import 'package:flutter/material.dart';

// use order list textfield -> ui list order
class OrderListTextFieldShop extends StatelessWidget {
  final void Function() onpress;
  final void Function(String) onchanged;
  final String title;
  final IconData icon;
  final IconData iconfx;
  final TextEditingController controller;
  const OrderListTextFieldShop(
      {super.key,
      required this.onchanged,
      required this.title,
      required this.icon,
      required this.controller,
      required this.onpress,
      required this.iconfx});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: TextFormField(
            cursorColor: Colors.black,
            autocorrect: false,
            controller: controller,
            onChanged: onchanged,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 7),
                        child: Icon(iconfx)),
                    onPressed: onpress),
                prefixIcon: Icon(icon),
                hintText: title,
                hintStyle: const TextStyle(fontSize: 16),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.25)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.25)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.25),
                    borderRadius: BorderRadius.circular(8.0)))));
  }
}
