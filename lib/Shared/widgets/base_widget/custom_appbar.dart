import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../utils/app_utils.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        elevation: 0,
        backgroundColor: fromHexColor(Constants.COLOR_APPBAR),
        centerTitle: true,
        title: Text(title),
        iconTheme: const IconThemeData(color: Colors.white));
  }
}
