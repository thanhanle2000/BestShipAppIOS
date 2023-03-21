import 'package:flutter/material.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/utils/app_utils.dart';

class OrderListMapAppbar extends StatelessWidget {
  final String title;
  const OrderListMapAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: fromHexColor(Constants.COLOR_APPBAR),
        centerTitle: true,
        title: Text(title),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.white),
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
