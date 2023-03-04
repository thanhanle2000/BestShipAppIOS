import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../utils/app_utils.dart';

// ignore: non_constant_identifier_names
SnackBar snackBar_message(String title, String messageType) {
  Color color = fromHexColor(Constants.COLOR_BUTTON);
  Icon icon = const Icon(Icons.noise_control_off);
  if (messageType == "error") {
    color = fromHexColor(Constants.COLOR_ERROR);
    icon = const Icon(Icons.error);
  }
  if (messageType == "warning") {
    color = fromHexColor(Constants.COLOR_APPBAR);
    icon = const Icon(Icons.replay_circle_filled_outlined);
  }
  if (messageType == "success") {
    color = fromHexColor(Constants.COLOR_BUTTON);
    icon = const Icon(Icons.done_outlined);
  }

  return SnackBar(
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      backgroundColor: color,
      content: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [Text(title), icon]));
}
