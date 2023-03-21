import 'package:flutter/material.dart';
import '../../../../Shared/constants/constants.dart';
import '../../../../Shared/utils/app_utils.dart';

class OrderListMapStatusAppbar extends StatefulWidget {
  final String title;
  const OrderListMapStatusAppbar({super.key, required this.title});

  @override
  State<OrderListMapStatusAppbar> createState() =>
      _OrderListMapStatusAppbarState();
}

class _OrderListMapStatusAppbarState extends State<OrderListMapStatusAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: fromHexColor(Constants.COLOR_APPBAR),
        centerTitle: true,
        title: Text(widget.title),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.white),
            onPressed: () => Navigator.pop(context)));
  }
}
