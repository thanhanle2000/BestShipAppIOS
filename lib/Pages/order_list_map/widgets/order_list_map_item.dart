import 'package:call_log/call_log.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Pages/order_list_map/bloc/map_bloc.dart';
import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/status/status_models.dart';
import '../../../Shared/utils/app_utils.dart';
import '../../../Shared/utils/get_call_log.dart';
import 'order_list_map_modalbottomsheet.dart';
import 'order_list_map_order_bottom_sheet.dart';

class MapConvertItem extends StatefulWidget {
  final OrderModels data;
  final StatusData statusModels;
  final BuildContext contextMain;
  final MapBloc mapBloc;
  const MapConvertItem(
      {super.key,
      required this.data,
      required this.statusModels,
      required this.contextMain,
      required this.mapBloc});

  @override
  State<MapConvertItem> createState() => MapConvertItemState();
}

typedef OnCallLogChangedCallback = void Function();

class MapConvertItemState extends State<MapConvertItem>
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
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
            context: widget.contextMain,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Wrap(children: [
                  OrderListModalBottomSheet(
                      hasTitle: false,
                      ui: OrderListMapInfoOrder(
                        data: widget.data,
                        status: widget.statusModels,
                        mapBloc: widget.mapBloc,
                        contextMain: widget.contextMain,
                      ))
                ]));
        // ignore: use_build_context_synchronously
        // Navigator.of(context).pop();
      },
      child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(top: 5),
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                GestureDetector(
                    onTap: () async {
                      await makeCall();
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
                      Navigator.pop(context);
                      showNotiCopy(
                          'Bạn vừa copy số điện thoại : ${widget.data.customerPhone}',
                          context);
                    },
                    child: const Icon(Icons.content_copy_outlined, size: 15))
              ]),
              Text(widget.data.customerName!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: fromHexColor(Constants.COLOR_APPBAR)))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Icon(Icons.monetization_on,
                    color: fromHexColor(Constants.COLOR_BUTTON), size: 15),
                const SizedBox(width: 4),
                Text(format_price(widget.data.codPrice),
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
                    style: const TextStyle(
                        fontSize: 15, color: Colours.textDefault))
              ])
            ]),
            SizedBox(
                width: double.infinity,
                child: Wrap(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.my_location_outlined,
                        color: fromHexColor(Constants.COLOR_BUTTON), size: 15),
                    const SizedBox(width: 4),
                    Expanded(
                        child: Wrap(children: [
                      Text(widget.data.customerAddress!,
                          style: const TextStyle(
                              fontSize: 17, color: Colours.textDefault))
                    ]))
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.view_day,
                        color: fromHexColor(Constants.COLOR_BUTTON), size: 15),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Wrap(children: [
                      Text(widget.data.shopOrderProduct!,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colours.textDefault))
                    ]))
                  ]),
                  const SizedBox(height: 5),
                  (!IsNullOrEmpty(widget.data.shopNote!))
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Icon(Icons.comment,
                                  color: fromHexColor(Constants.COLOR_BUTTON),
                                  size: 15),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: Wrap(children: [
                                Text(widget.data.shopNote!,
                                    style: const TextStyle(
                                        color: Colours.textDefault,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline))
                              ]))
                            ])
                      : const SizedBox(),
                  const SizedBox(height: 5),
                  (!IsNullOrEmpty(widget.data.orderStatusNote!))
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Icon(Icons.comment,
                                  color: fromHexColor(Constants.COLOR_APPBAR),
                                  size: 15),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: Wrap(children: [
                                Text(widget.data.orderStatusNote!,
                                    style: const TextStyle(
                                        color: Colours.textDefault,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline))
                              ]))
                            ])
                      : const SizedBox(),
                  const SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        !IsNullOrEmpty(widget.data.shopPhone!)
                            ? Row(children: [
                                GestureDetector(
                                    onTap: () async {
                                      // ignore: deprecated_member_use
                                      launch(
                                          'tel://${widget.data.shopPhone}'); // phương thức gọi
                                    },
                                    child: Text(widget.data.shopPhone!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: fromHexColor(
                                                Constants.COLOR_APPBAR)))),
                                const SizedBox(width: 5),
                                GestureDetector(
                                    onTap: () {
                                      FlutterClipboard.copy(
                                          widget.data.shopPhone!);
                                      Navigator.pop(context);
                                      showNotiCopy(
                                          'Bạn vừa copy số điện thoại : ${widget.data.shopPhone}',
                                          context);
                                    },
                                    child: const Icon(
                                        Icons.content_copy_outlined,
                                        size: 15))
                              ])
                            : const SizedBox(),
                        Text(widget.data.shopName!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: fromHexColor(Constants.COLOR_APPBAR)))
                      ]),
                ]))
          ])),
    );
  }
}
