import 'package:flutter/material.dart';

import '../../../../Shared/blocs/theme/color.dart';

// use login pass
// ignore: must_be_immutable
class AuthTextFieldPassword extends StatefulWidget {
  final String? Function(String?)? validator;
  final Function() onpress;
  final String hintText;
  final TextEditingController myControllers;
  final bool ispass;
  bool check;
  AuthTextFieldPassword(
      {super.key,
      required this.hintText,
      required this.check,
      required this.myControllers,
      required this.onpress,
      required this.ispass,
      this.validator});

  @override
  State<AuthTextFieldPassword> createState() => _AuthTextFieldPasswordState();
}

class _AuthTextFieldPasswordState extends State<AuthTextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: Colors.black,
        controller: widget.myControllers,
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Vui lòng nhập (*)',
            contentPadding:
                const EdgeInsets.only(left: 5, top: 10, right: 20, bottom: 10),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(5.0),
            ),
            disabledBorder:
                const OutlineInputBorder(borderSide: BorderSide(width: 0.125)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colours.active_button, width: 0.25),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45, width: 0.25),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            suffixIcon: IconButton(
              icon: Icon(widget.check ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark),
              onPressed: widget.onpress,
            )),
        obscureText: !widget.ispass,
        validator: widget.validator);
  }
}
