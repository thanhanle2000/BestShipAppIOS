import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'app_utils.dart';

// ignore: non_constant_identifier_names
app_loading(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: CircularProgressIndicator(
                color: fromHexColor(Constants.COLOR_BUTTON)));
      });
}
