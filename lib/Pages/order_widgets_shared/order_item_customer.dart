import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Shared/blocs/theme/color.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/models/order_list/order_list_models.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';

// widget use customer
// ignore: camel_case_types
class OrderItemCustomer extends StatefulWidget {
  final OrderModels data;
  const OrderItemCustomer({super.key, required this.data});

  @override
  State<OrderItemCustomer> createState() => OrderItemCustomerState();
}

// ignore: camel_case_types
class OrderItemCustomerState extends State<OrderItemCustomer> {
  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "vi_VN");
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          GestureDetector(
              onTap: () async {
                // ignore: deprecated_member_use
                launch('tel://${widget.data.customerPhone}'); // phương thức gọi
              },
              child: Text(widget.data.customerPhone!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: fromHexColor(Constants.COLOR_APPBAR)))),
          const SizedBox(width: 5),
          GestureDetector(
              onTap: () {
                FlutterClipboard.copy(widget.data.customerPhone!);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    snackBar_message(
                        'Bạn vừa copy số điện thoại: ${widget.data.customerPhone}',
                        "success"),
                  );
              },
              child: const Icon(Icons.content_copy_outlined, size: 15))
        ]),
        Text(widget.data.customerName!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: fromHexColor(Constants.COLOR_APPBAR)))
      ]),
      const SizedBox(height: 5),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.my_location_outlined,
            color: fromHexColor(Constants.COLOR_BUTTON), size: 15),
        const SizedBox(width: 4),
        Expanded(
            child: Wrap(children: [
          Text(widget.data.customerAddress!,
              style: const TextStyle(fontSize: 17, color: Colours.textDefault))
        ]))
      ]),
      const SizedBox(height: 5),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Wrap(
              children: [
                Text('${widget.data.wardname!} - ${widget.data.districtname!}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colours.textDefault))
              ],
            )),
            GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: widget.data.orderCode));
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      snackBar_message(
                          'Bạn vừa copy mã vận đơn: ${widget.data.orderCode}',
                          "success"),
                    );
                },
                child: Row(children: [
                  Text(widget.data.orderCode!,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colours.textDefault,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5),
                  const Icon(Icons.content_copy_outlined, size: 15)
                ]))
          ]),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Icon(Icons.monetization_on,
              color: fromHexColor(Constants.COLOR_BUTTON), size: 15),
          const SizedBox(width: 4),
          Text(oCcy.format(widget.data.codPrice),
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colours.textDefault))
        ]),
        Row(children: [
          Icon(Icons.date_range,
              color: fromHexColor(Constants.COLOR_BUTTON), size: 15),
          const SizedBox(width: 4),
          Text(
              DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(widget.data.orderDate!)),
              style: const TextStyle(fontSize: 15, color: Colours.textDefault))
        ])
      ]),
    ]);
  }
}
