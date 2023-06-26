import 'package:flutter/material.dart';

import '../../../../Shared/blocs/theme/color.dart';

// sử dụng trong ui login
class AuthTextFieldAccount extends StatelessWidget {
  final String? Function(String?)? validator;
  final String hintText;
  final TextEditingController myController;
  const AuthTextFieldAccount(
      {super.key,
      required this.hintText,
      required this.myController,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: myController,
      keyboardType: TextInputType.text,
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
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
          borderSide: BorderSide(color: Colours.active_button, width: 0.125),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 0.125),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.125),
          borderRadius: BorderRadius.circular(5.0),
        ),
        suffixIcon: myController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => myController.clear(),
              )
            : null,
      ),
    );
  }
}
