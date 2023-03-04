import 'package:flutter/material.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/utils/app_utils.dart';

class Scanfield extends StatelessWidget {
  final void Function() onpress;
  final void Function(String) onSubmit;
  final void Function() onFocus;
  final String title;
  final IconData icon;
  final IconData iconfx;
  final TextEditingController controller;
  const Scanfield(
      {super.key,
      required this.title,
      required this.icon,
      required this.controller,
      required this.onpress,
      required this.iconfx,
      required this.onFocus,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48,
        margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
            cursorColor: Colors.black,
            autocorrect: false,
            onFieldSubmitted: onSubmit,
            onEditingComplete: onFocus,
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, bottom: 5, top: 5, right: 5),
                        child: Icon(iconfx,
                            color: fromHexColor(Constants.COLOR_BUTTON))),
                    onPressed: onpress),
                prefixIcon:
                    Icon(icon, color: fromHexColor(Constants.COLOR_BUTTON)),
                hintText: title,
                contentPadding: const EdgeInsets.only(top: 15),
                hintStyle: const TextStyle(fontSize: 16),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.125)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.125)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.125),
                    borderRadius: BorderRadius.circular(8)))));
  }
}
