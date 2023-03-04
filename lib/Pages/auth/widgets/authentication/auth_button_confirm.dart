import 'package:flutter/material.dart';

import '../../../../Shared/constants/constants.dart';
import '../../../../Shared/utils/app_utils.dart';
import '../../../../Shared/widgets/loading.dart';

class AuthButtonConfirm extends StatelessWidget {
  final Color color;
  final String title;
  final void Function()? onTap;
  final double width;
  final bool? isSubmitting;

  const AuthButtonConfirm(
      {super.key,
      required this.color,
      required this.title,
      required this.onTap,
      required this.width,
      required this.isSubmitting});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  fromHexColor(Constants.COLOR_BUTTON))),
          child: isSubmitting!
              ? loading()
              : Center(
                  child: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ))),
    );
  }
}
