
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../utils/app_utils.dart';

Widget loadingIndicator() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
        child: CircularProgressIndicator(
            color: fromHexColor(Constants.COLOR_BUTTON))),
  );
}
