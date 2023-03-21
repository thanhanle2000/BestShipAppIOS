import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_event.dart';
import 'package:flutter_app_best_shipp/Shared/blocs/theme/color.dart';
import 'package:flutter_app_best_shipp/Shared/constants/constants.dart';
import 'package:flutter_app_best_shipp/Shared/utils/app_utils.dart';
import 'package:intl/intl.dart';

import '../../../Shared/models/auth/tag_key/tagkeyword.dart';
import '../../payment_shipper/widgets/payment_shipper_confirm.dart';

class OrderProcessDateRange extends StatefulWidget {
  final Function(String) date;
  final OrderProcessBloc orderBloc;
  final BuildContext blocContext;

  const OrderProcessDateRange(
      {super.key,
      required this.date,
      required this.orderBloc,
      required this.blocContext});

  @override
  State<OrderProcessDateRange> createState() => _OrderProcessDateRangeState();
}

class _OrderProcessDateRangeState extends State<OrderProcessDateRange> {
  int _currentTimeValue = 1;
  int idShopSelect = 1;
  String tileStartDate = '';
  String tileEndDate = '';
  String date = '';
  String dateStart = '';
  String dateEnd = '';
  String timeStart = '';
  String timeEnd = '';
  // sự kiện lọc theo ngày
  // ignore: body_might_complete_normally_nullable
  Future<void>? getFilterShop(
      String dateStart, String dateEnd, BuildContext contextbloc) {
    widget.orderBloc.add(OrderProcessFilterDateEvent(
        startDate: dateStart,
        endDate: dateEnd,
        blocContext: contextbloc,
        processBloc: widget.orderBloc));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              border: const Border(
                  top: BorderSide(width: 1, color: Colours.textDefault))),
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: const Text('Chọn mốc thời gian lọc',
              style: TextStyle(fontSize: 18, color: Colours.classicText))),
      Column(
          children: lstDate
              .map((e) => RadioListTile<int>(
                    // ignore: prefer_const_constructors
                    visualDensity: VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                    contentPadding: const EdgeInsets.fromLTRB(2, 8, 2, 0),
                    groupValue: _currentTimeValue,
                    title: Text(e.date!),
                    value: e.id!,
                    onChanged: (val) {
                      setState(() {
                        _currentTimeValue = val!;
                        idShopSelect = e.id!;
                        date = e.date!;
                        timeStart = e.dateStart!;
                        timeEnd = e.dateEnd!;
                      });
                    },
                  ))
              .toList()),
      idShopSelect == 10
          ? Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => pickDateRange(),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.date_range_rounded,
                            color: Colors.blue),
                        Text(
                          IsNullOrEmpty(dateStart)
                              ? 'Chọn thời gian'
                              : '$tileStartDate  :  $tileEndDate',
                          style: const TextStyle(
                              fontSize: 16, color: Colours.classicText),
                        ),
                        const Icon(Icons.keyboard_arrow_down_outlined,
                            color: Colors.blue)
                      ])))
          : const SizedBox(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        PaymentShipperConfirm(
          onpress: () async {
            IsNullOrEmpty(dateStart)
                ? await getFilterShop(timeStart, timeEnd, widget.blocContext)
                : await getFilterShop(dateStart, dateEnd, widget.blocContext);
            widget.date(date);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          title: 'Xác nhận',
          colorString: Constants.COLOR_BUTTON,
          lr: 40,
        ),
        PaymentShipperConfirm(
            onpress: () => Navigator.pop(context),
            title: 'Đóng',
            colorString: Constants.COLOR_APPBAR,
            lr: 50)
      ])
    ]);
  }

  DateTimeRange daterange = DateTimeRange(
      start: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      end: DateTime.now());

  Future pickDateRange() async {
    DateTimeRange? newDate = await showDateRangePicker(
        context: context, firstDate: DateTime(2020), lastDate: DateTime.now());
    if (newDate == null) {
      return;
    }
    setState(() {
      daterange = newDate;
      tileStartDate = DateFormat('dd-MM-yyyy').format(daterange.start);
      tileEndDate = DateFormat('dd-MM-yyyy').format(daterange.end);
      dateStart = DateFormat('yyyy-MM-dd').format(daterange.start);
      dateEnd = DateFormat('yyyy-MM-dd').format(daterange.end);
    });
  }

  // danh sách mốc thời gian
  List<DateRangeModels> lstDate = [
    DateRangeModels(
        id: 2,
        date: 'Hôm nay',
        dateStart: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        dateEnd: DateFormat('yyyy-MM-dd').format(DateTime.now())),
    DateRangeModels(
        id: 3,
        date: 'Hôm qua',
        dateStart: DateFormat('yyyy-MM-dd').format(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
        dateEnd: DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day - 1))),
    DateRangeModels(
        id: 4,
        date: '7 ngày trước',
        dateStart: DateFormat('yyyy-MM-dd').format(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 6)),
        dateEnd: DateFormat('yyyy-MM-dd').format(DateTime.now())),
    DateRangeModels(
        id: 5,
        date: '15 ngày trước',
        dateStart: DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day - 14)),
        dateEnd: DateFormat('yyyy-MM-dd').format(DateTime.now())),
    DateRangeModels(
        id: 6,
        date: 'Trong tháng',
        dateStart: DateFormat('yyyy-MM-dd').format(DateTime(
            DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)),
        dateEnd: DateFormat('yyyy-MM-dd').format(DateTime.now())),
    DateRangeModels(
        id: 7,
        date: 'Tháng trước',
        dateStart: DateFormat('yyyy-MM-dd').format(DateTime(
            DateTime.now().year, DateTime.now().month - 2, DateTime.now().day)),
        dateEnd: DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year,
            DateTime.now().month - 1, DateTime.now().day))),
    DateRangeModels(
        id: 10, date: 'Tùy chọn thời gian', dateStart: '', dateEnd: ''),
  ];
}
