import 'package:flutter/material.dart';
import '../../blocs/theme/color.dart';

Widget endData() {
  return Container(
      margin: const EdgeInsets.only(top: 3),
      alignment: Alignment.center,
      color: Colors.white,
      height: 40,
      width: double.maxFinite,
      child: const Text('Bạn đã xem hết danh sách',
          style: TextStyle(fontSize: 15, color: Colours.textDefault),
          textAlign: TextAlign.center));
}
