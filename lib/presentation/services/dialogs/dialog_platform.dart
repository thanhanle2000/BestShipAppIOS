import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialog_service.dart';

const TextStyle _defaultTextStyle = TextStyle(color: Colors.black);
const TextStyle _cancelTextStyle = TextStyle(color: Colors.red);

class PlatformButton extends StatelessWidget {
  final DialogPlatform? dialogPlatform;
  final String? text;
  final void Function()? onPressed;
  final bool isCancelButton;

  const PlatformButton({
    Key? key,
    this.dialogPlatform,
    this.isCancelButton = false,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (dialogPlatform) {
      case DialogPlatform.Cupertino:
        return CupertinoDialogAction(
          child: Text(
            text!,
            style: isCancelButton ? _cancelTextStyle : null,
          ),
          onPressed: onPressed,
        );

      case DialogPlatform.Material:
      default:
        return TextButton(
          child: Text(text!,
              style: isCancelButton ? _cancelTextStyle : _defaultTextStyle),
          onPressed: onPressed,
        );
    }
  }
}

class PlatformDialog extends StatelessWidget {
  /// The title of the dialog is displayed in a large font at the top
  final String? title;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided. Otherwise, this padding
  /// is used.
  ///
  /// This property defaults to providing 24 pixels on the top, left, and right
  /// of the title. If the [content] is not null, then no bottom padding is
  /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
  /// pixels of bottom padding is added to separate the [title] from the
  /// [actions].
  final EdgeInsetsGeometry? titlePadding;

  /// Style for the text in the [title] of this [AlertDialog].
  final TextStyle? titleTextStyle;

  /// The content of the dialog is displayed in the center of the dialog
  final String? content;

  /// Padding around the content.
  final EdgeInsetsGeometry contentPadding;

  /// Style for the text in the [content] of this [AlertDialog].
  final TextStyle contentTextStyle;

  /// The set of actions that are displayed at the bottom of the
  /// dialog.
  final List<Widget>? actions;

  final DialogPlatform dialogPlatform;

  final String? cancelText;

  const PlatformDialog({
    Key? key,
    this.title,
    this.titlePadding,
    this.titleTextStyle = _defaultTextStyle,
    this.content,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.contentTextStyle = _defaultTextStyle,
    this.actions,
    this.dialogPlatform = DialogPlatform.Material,
    this.cancelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (dialogPlatform) {
      case DialogPlatform.Cupertino:
        return CupertinoAlertDialog(
          title: Text(
            title!,
          ),
          content: Text(
            content!,
          ),
          actions: actions!,
        );
      case DialogPlatform.Material:
      default: // TODO: When custom dialog registrations are implemented it'll be shown here
        return AlertDialog(
          titleTextStyle: Theme.of(context).dialogTheme.titleTextStyle,
          contentTextStyle: Theme.of(context).dialogTheme.contentTextStyle,
          title: Text(title!),
          content: Text(content!),
          actions: actions,
        );
    }
  }
}
