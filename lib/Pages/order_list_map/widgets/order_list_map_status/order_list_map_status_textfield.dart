import 'package:flutter/material.dart';

class OrderListStatusTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  const OrderListStatusTextFields(
      {super.key,
      required this.controller,
      required this.validator,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            autofocus: false,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: title,
                hintStyle: const TextStyle(fontSize: 15),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                contentPadding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                // ignore: prefer_const_constructors
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.125)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.125)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.125),
                    borderRadius: BorderRadius.circular(8)))));
  }
}
