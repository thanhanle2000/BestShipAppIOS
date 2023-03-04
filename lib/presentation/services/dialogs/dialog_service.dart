import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/constants/constants.dart';
import 'package:get/get.dart';

import 'dialog_platform.dart';

enum DialogPlatform {
  // ignore: constant_identifier_names
  Cupertino,
  // ignore: constant_identifier_names
  Material,
  // ignore: constant_identifier_names
  Custom,
}

class DialogService {
  Completer<DialogResponse>? _dialogCompleter;

  Widget Function(BuildContext, DialogRequest)? _customDialogUI;

  get navigatorKey {
    return Get.key;
  }

  void registerCustomDialogUi(
      Widget Function(BuildContext, DialogRequest) dialogBuilder) {
    _customDialogUI = dialogBuilder;
  }

  // TODO: Create a dialog UI registration factory that will allow users to register
  // dialogs to be built along with keys. the user should then be able to show the dialog
  // using that key.

  /// Shows a dialog to the user
  ///
  /// It will show a platform specific dialog by default. This can be changed by setting [dialogPlatform]
  Future<DialogResponse> showDialog({
    String title = Constants.APP_NAME,
    String? description,
    String? cancelTitle,
    String buttonTitle = 'Ok',

    /// Indicates which [DialogPlatform] to show.
    ///
    /// When not set a Platform specific dialog will be shown
    DialogPlatform? dialogPlatform,
  }) {
    _dialogCompleter = Completer<DialogResponse>();

    if (dialogPlatform != null) {
      _showDialog(
          title: title,
          description: description!,
          cancelTitle: cancelTitle!,
          buttonTitle: buttonTitle,
          dialogPlatform: dialogPlatform);
    } else {
      // ignore: no_leading_underscores_for_local_identifiers
      var _dialogType = GetPlatform.isAndroid
          ? DialogPlatform.Material
          : DialogPlatform.Cupertino;
      _showDialog(
          title: title,
          description: description!,
          cancelTitle: cancelTitle!,
          buttonTitle: buttonTitle,
          dialogPlatform: _dialogType);
    }

    return _dialogCompleter!.future;
  }

  Future _showDialog({
    String? title,
    String? description,
    String? cancelTitle,
    String? buttonTitle,
    DialogPlatform? dialogPlatform,
  }) {
    var isConfirmationDialog = cancelTitle != null;
    return Get.dialog(
      PlatformDialog(
        dialogPlatform: dialogPlatform!,
        title: title,
        content: description,
        actions: <Widget>[
          if (isConfirmationDialog)
            PlatformButton(
              dialogPlatform: dialogPlatform,
              text: cancelTitle,
              isCancelButton: true,
              onPressed: () {
                if (!_dialogCompleter!.isCompleted)
                  // ignore: curly_braces_in_flow_control_structures
                  completeDialog(
                    DialogResponse(
                      confirmed: false,
                    ),
                  );
              },
            ),
          PlatformButton(
            dialogPlatform: dialogPlatform,
            text: buttonTitle,
            onPressed: () {
              if (!_dialogCompleter!.isCompleted)
                // ignore: curly_braces_in_flow_control_structures
                completeDialog(
                  DialogResponse(
                    confirmed: true,
                  ),
                );
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  // Creates a popup with the given widget, a scale animation, and faded background.
  Future<DialogResponse> showCustomDialog({
    String title = Constants.APP_NAME,
    String? description,
    bool hasImage = false,
    String? imageUrl,
    bool showIconInMainButton = false,
    String? mainButtonTitle,
    bool showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool takesInput = false,
    dynamic customData,
  }) {
    assert(_customDialogUI != null,
        'You have to call registerCustomDialogUi to use this function. Look at the custom dialog UI section in the stacked_services readme.');

    _dialogCompleter = Completer<DialogResponse>();

    Get.generalDialog(
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      pageBuilder: (BuildContext buildContext, _, __) => SafeArea(
          child: Builder(
              builder: (BuildContext context) => _customDialogUI!(
                  context,
                  DialogRequest(
                    title: title,
                    description: description!,
                    hasImage: hasImage,
                    imageUrl: imageUrl!,
                    showIconInMainButton: showIconInMainButton,
                    mainButtonTitle: mainButtonTitle!,
                    showIconInSecondaryButton: showIconInSecondaryButton,
                    secondaryButtonTitle: secondaryButtonTitle!,
                    showIconInAdditionalButton: showIconInAdditionalButton,
                    additionalButtonTitle: additionalButtonTitle!,
                    takesInput: takesInput,
                    customData: customData,
                  )))),
      // TODO: Add configurable transition builders to set  from the outside as well
      // transitionBuilder: (context, animation, _, child) {
      //   return ScaleTransition(
      //     scale: CurvedAnimation(
      //       parent: animation,
      //       curve: Curves.decelerate,
      //     ),
      //     child: child,
      //   );
      // },
    );

    return _dialogCompleter!.future;
  }

  /// Shows a confirmation dialog with title and description
  Future<DialogResponse> showConfirmationDialog({
    String title = Constants.APP_NAME,
    String? description,
    String cancelTitle = 'Cancel',
    String confirmationTitle = 'Ok',

    /// Indicates which [DialogPlatform] to show.
    ///
    /// When not set a Platform specific dialog will be shown
    DialogPlatform? dialogPlatform,
  }) {
    _dialogCompleter = Completer<DialogResponse>();

    showDialog(
      title: title,
      description: description,
      buttonTitle: confirmationTitle,
      cancelTitle: cancelTitle,
      dialogPlatform: dialogPlatform,
    );

    return _dialogCompleter!.future;
  }

  /// Completes the dialog and passes the [response] to the caller
  void completeDialog(DialogResponse response) {
    Get.back();
    _dialogCompleter!.complete(response);
    _dialogCompleter = null;
  }
}

/// The response returned from awaiting a call on the [DialogService]
class DialogResponse {
  /// Indicates if a [showConfirmationDialog] has been confirmed or rejected.
  /// null will be returned when it's not a confirmation dialog.
  final bool? confirmed;

  /// A place to put any response data from dialogs that may contain text fields
  /// or multi selection options
  final List<dynamic>? responseData;

  DialogResponse({
    this.confirmed,
    this.responseData,
  });
}

class DialogRequest {
  /// The title for the dialog
  final String? title;

  /// Text so show in the dialog body
  final String? description;

  /// Indicates if an image should be used or not
  final bool? hasImage;

  /// The url / path to the image to show
  final String? imageUrl;

  /// The text shown in the main button
  final String? mainButtonTitle;

  /// A bool to indicate if you should show an icon in the main button
  final bool? showIconInMainButton;

  /// The text to show on the secondary button on the dialog (cancel usually)
  final String? secondaryButtonTitle;

  /// Indicates if you should show an icon in the main button
  final bool? showIconInSecondaryButton;

  /// The text show on the third button on the dialog
  final String? additionalButtonTitle;

  /// Indicates if you should show an icon in the additional button
  final bool? showIconInAdditionalButton;

  /// Indicates if the dialog takes input
  final bool? takesInput;

  /// Intended to be used with enums. If you want to create multiple different
  /// dialogs. Pass your enum in here and check the value in the builder
  final dynamic customData;

  DialogRequest({
    this.showIconInMainButton,
    this.showIconInSecondaryButton,
    this.showIconInAdditionalButton,
    this.title,
    this.description,
    this.hasImage,
    this.imageUrl,
    this.mainButtonTitle,
    this.secondaryButtonTitle,
    this.additionalButtonTitle,
    this.takesInput,
    this.customData,
  });
}
