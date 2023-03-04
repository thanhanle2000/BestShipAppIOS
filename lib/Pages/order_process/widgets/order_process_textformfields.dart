import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/blocs/theme/color.dart';

class OrderProcessTextFormFields extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onTap;
  final String? title;
  final void Function()? onPressed;
  final void Function(String)? onSubmit;
  final IconData? iconData;

  const OrderProcessTextFormFields(
      {super.key,
      this.controller,
      this.onTap,
      this.title,
      this.onPressed,
      this.onSubmit,
      this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 43,
        color: Colors.grey[50],
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: TextFormField(
            autofocus: true,
            cursorColor: Colors.black,
            autocorrect: false,
            controller: controller,
            onFieldSubmitted: onSubmit,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 7),
                    child: Icon(Icons.clear, size: 27),
                  ),
                  onPressed: onPressed,
                ),
                prefixIcon:
                    GestureDetector(onTap: onTap, child: Icon(iconData)),
                hintText: title,
                hintStyle:
                    const TextStyle(fontSize: 16, color: Colours.classicText),
                contentPadding:
                    const EdgeInsets.fromLTRB(25.0, 20.0, 20.0, 0.0),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.25)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.25)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.25),
                    borderRadius: BorderRadius.circular(8.0)))));
  }
}
