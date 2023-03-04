import 'package:flutter/material.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/utils/app_utils.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  const HomeAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: fromHexColor(Constants.COLOR_APPBAR),
      centerTitle: true,
      title: Text(title),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
