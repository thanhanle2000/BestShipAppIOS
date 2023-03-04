import 'package:flutter/material.dart';

Widget loading() {
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [CircularProgressIndicator(color: Colors.white)]);
}
