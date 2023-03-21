import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Shared/blocs/theme/color.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/models/order_list/order_list_models.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';

// widget use payment
// ignore: camel_case_types
class OrderItemPayment extends StatefulWidget {
  final OrderModels data;
  const OrderItemPayment({super.key, required this.data});

  @override
  State<OrderItemPayment> createState() => OrderItemPaymentState();
}

// ignore: camel_case_types
class OrderItemPaymentState extends State<OrderItemPayment> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 3),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.view_day,
            color: fromHexColor(Constants.COLOR_BUTTON), size: 14),
        const SizedBox(width: 5),
        Expanded(
            child: Wrap(children: [
          Text(widget.data.shopOrderProduct!,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colours.textDefault))
        ]))
      ]),
      const SizedBox(height: 3),
      (!IsNullOrEmpty(widget.data.shopNote!))
          ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.comment,
                  color: fromHexColor(Constants.COLOR_BUTTON), size: 14),
              const SizedBox(width: 5),
              Expanded(
                  child: Wrap(children: [
                Text(widget.data.shopNote!,
                    style: const TextStyle(
                        color: Colours.textDefault,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline))
              ]))
            ])
          : const SizedBox(),
      const SizedBox(height: 3),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          !IsNullOrEmpty(widget.data.shopPhone!)
              ? GestureDetector(
                  onTap: () async =>
                      // ignore: deprecated_member_use
                      launch('tel://${widget.data.shopPhone}'),
                  child: Text(widget.data.shopPhone!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: fromHexColor(Constants.COLOR_APPBAR))))
              : const SizedBox(),
          const SizedBox(width: 5),
          !IsNullOrEmpty(widget.data.shopPhone!)
              ? GestureDetector(
                  onTap: () {
                    FlutterClipboard.copy(widget.data.shopPhone!);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        snackBar_message(
                            'Bạn vừa copy số điện thoại: ${widget.data.shopPhone}',
                            "success"),
                      );
                  },
                  child: const Icon(Icons.content_copy_outlined, size: 14))
              : const SizedBox()
        ]),
        Text(widget.data.shopName!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: fromHexColor(Constants.COLOR_APPBAR)))
      ])
    ]);
  }
}
