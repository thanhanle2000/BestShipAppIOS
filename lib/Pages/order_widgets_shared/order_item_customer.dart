import 'package:call_log/call_log.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Shared/blocs/theme/color.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/models/order_list/order_list_models.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/utils/get_call_log.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';

// widget use customer
// ignore: camel_case_types
class OrderItemCustomer extends StatefulWidget {
  final OrderModels data;
  const OrderItemCustomer({super.key, required this.data});

  @override
  State<OrderItemCustomer> createState() => OrderItemCustomerState();
}

typedef OnCallLogChangedCallback = void Function();

// ignore: camel_case_types
class OrderItemCustomerState extends State<OrderItemCustomer>
    with WidgetsBindingObserver {
  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
  CallLogEntry? _currentCallLogEntry;
  OnCallLogChangedCallback? _onCallLogChangedCallback;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateCallLogEntries();
    }
  }

  void setOnCallLogChangedCallback(OnCallLogChangedCallback callback) {
    _onCallLogChangedCallback = callback;
  }

  Future<void> updateCallLogEntries() async {
    final Iterable<CallLogEntry> previousCallLogEntries = await CallLog.query();
    setState(() {
      _callLogEntries = previousCallLogEntries;
    });

    final Iterable<CallLogEntry> updatedCallLogEntries = await CallLog.query();
    setState(() {
      _callLogEntries = updatedCallLogEntries;
    });

    if (_callLogEntries.isNotEmpty) {
      final CallLogEntry latestCallLogEntry = _callLogEntries.first;
      if (latestCallLogEntry.duration != null) {
        setState(() {
          _currentCallLogEntry = latestCallLogEntry;
        });
        saveCallLog(widget.data.id!, latestCallLogEntry.duration!);
        print('Latest Duration: ${latestCallLogEntry.duration} seconds');
        _onCallLogChangedCallback?.call();
      }
    }
  }

  Future<void> makeCall() async {
    launch('tel://${widget.data.customerPhone}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await makeCall();
                  },
                  child: Text(
                    widget.data.customerPhone!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: fromHexColor(Constants.COLOR_APPBAR),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    FlutterClipboard.copy(widget.data.customerPhone!);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        snackBar_message(
                          'Bạn vừa copy số điện thoại: ${widget.data.customerPhone}',
                          "success",
                        ),
                      );
                  },
                  child: const Icon(Icons.content_copy_outlined, size: 14),
                ),
              ],
            ),
            Text(
              widget.data.customerName!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: fromHexColor(Constants.COLOR_APPBAR),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.my_location_outlined,
              color: fromHexColor(Constants.COLOR_BUTTON),
              size: 14,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Wrap(
                children: [
                  Text(
                    widget.data.customerAddress!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colours.textDefault,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Wrap(
                children: [
                  Text(
                    '${widget.data.wardname!} - ${widget.data.districtname!}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colours.textDefault,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: widget.data.orderCode));
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    snackBar_message(
                      'Bạn vừa copy mã vận đơn: ${widget.data.orderCode}',
                      "success",
                    ),
                  );
              },
              child: Row(
                children: [
                  Text(
                    widget.data.orderCode!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colours.textDefault,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.content_copy_outlined, size: 14),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  color: fromHexColor(Constants.COLOR_BUTTON),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  format_price(widget.data.codPrice),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colours.textDefault,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.date_range,
                  color: fromHexColor(Constants.COLOR_BUTTON),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat("dd-MM-yyyy")
                      .format(DateTime.parse(widget.data.orderDate!)),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colours.textDefault,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
