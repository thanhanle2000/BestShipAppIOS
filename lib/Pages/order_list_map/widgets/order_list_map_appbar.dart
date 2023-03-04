import 'package:flutter/material.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/utils/app_utils.dart';

class OrderListMapAppbar extends StatefulWidget {
  final String title;
  const OrderListMapAppbar({super.key, required this.title});

  @override
  State<OrderListMapAppbar> createState() => _OrderListMapAppbarState();
}

class _OrderListMapAppbarState extends State<OrderListMapAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: fromHexColor(Constants.COLOR_APPBAR),
        centerTitle: true,
        title: Text(widget.title),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          Builder(builder: (context) {
            return IconButton(
                icon: const Icon(Icons.menu_outlined),
                onPressed: () => Scaffold.of(context).openEndDrawer());
          })
        ]);
  }
}
