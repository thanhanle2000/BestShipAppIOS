import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../utils/app_utils.dart';

// ignore: non_constant_identifier_names
SnackBar snackBar_loading() {
  return SnackBar(
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      backgroundColor: fromHexColor(Constants.COLOR_APPBAR),
      content: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text("Vui lòng chờ..."),
            const CircularProgressIndicator()
          ]));
}
