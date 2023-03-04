import 'package:flutter/material.dart';

class ButtonConfirm extends StatelessWidget {
  final void Function() onpress;
  final String title;
  final Color color;
  const ButtonConfirm(
      {super.key,
      required this.onpress,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
        onPressed: onpress,
        child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Text(title,
                style: const TextStyle(fontSize: 15, color: Colors.white))));
  }
}
