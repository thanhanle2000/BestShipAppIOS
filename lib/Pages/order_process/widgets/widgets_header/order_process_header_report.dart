import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_event.dart';
import 'package:intl/intl.dart';

import '../../../../Shared/blocs/theme/color.dart';
import '../../../../Shared/widgets/base_widget/snackbar_message.dart';
import '../../bloc/order_process_bloc.dart';
import 'order_process_header_textfield.dart';

// header trả về total order list -> ui order list
class OrderProcessHeaderReport extends StatefulWidget {
  final int? total;
  final int? totalSuc;
  final int? totalPro;
  final int? totalOth;
  final OrderProcessBloc orderBloc;
  final BuildContext blocContext;
  const OrderProcessHeaderReport({
    super.key,
    required this.total,
    required this.totalSuc,
    required this.totalPro,
    required this.totalOth,
    required this.orderBloc,
    required this.blocContext,
  });

  @override
  State<OrderProcessHeaderReport> createState() =>
      _OrderProcessHeaderReportState();
}

class _OrderProcessHeaderReportState extends State<OrderProcessHeaderReport> {
  TextEditingController controller = TextEditingController();
  bool isActive = false;

  @override
  void dispose() {
    super.dispose();
  }

  // hàm xử lí search order textfields -> header
  // ignore: body_might_complete_normally_nullable
  Future<void>? onSearchTextFields(
      String customerPhone, BuildContext blocContext) {
    widget.orderBloc.add(OrderProcessFilterPhoneEvent(
        customerPhone: customerPhone,
        blocContext: blocContext,
        processBloc: widget.orderBloc));
  }

  // hàm xử lí search order textfields -> header
  // ignore: body_might_complete_normally_nullable
  Future<void>? onSort(String SortType, BuildContext blocContext) {
    widget.orderBloc.add(OrderProcessFilterSortEvent(
        SortType: SortType,
        blocContext: blocContext,
        processBloc: widget.orderBloc));
  }

  // thông số
  final text_title = 15.0;
  final text_number = 18.0;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "vi_VN");
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: const Border(
              bottom: BorderSide(width: 0.5, color: Colours.textDefault))),
      child: Column(children: [
        OrderProcessHeaderTextFields(
          iconData: Icons.content_paste,
          title: 'Nhập vào số điện thoại',
          controller: controller,
          onSubmit: (value) {
            onSearchTextFields(value, widget.blocContext);
          },
          onPressed: () async {
            controller.clear();
            await onSearchTextFields(' ', widget.blocContext);
          },
          onTap: () async {
            final value = await FlutterClipboard.paste();
            controller.text = value;
          },
        ),
        Container(
            height: 56,
            color: Colors.grey[50],
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('Tổng : ',
                            style: TextStyle(
                                fontSize: text_title, color: Colors.grey[600])),
                        const SizedBox(height: 5),
                        Text('Thành công : ',
                            style: TextStyle(
                                fontSize: text_title, color: Colors.grey[600])),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(oCcy.format(widget.total),
                            style: TextStyle(
                                fontSize: text_number,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                        Text(oCcy.format(widget.totalSuc),
                            style: TextStyle(
                                fontSize: text_number,
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ]),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text('Đang giao : ',
                              style: TextStyle(
                                  fontSize: text_title,
                                  color: Colors.grey[600])),
                          const SizedBox(height: 5),
                          Text('Khác : ',
                              style: TextStyle(
                                  fontSize: text_title,
                                  color: Colors.grey[600])),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(oCcy.format(widget.totalPro),
                              style: TextStyle(
                                  fontSize: text_number,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold)),
                          Text(oCcy.format(widget.totalOth),
                              style: TextStyle(
                                  fontSize: text_number,
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () async {
                        isActive = !isActive;
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            snackBar_message(
                                isActive
                                    ? 'Bạn vừa sắp xếp tăng dần.'
                                    : 'Bạn vừa sắp xếp giảm dần.',
                                "success"),
                          );
                        await onSort(isActive ? 'Address_ASC' : 'Address_DESC',
                            widget.blocContext);
                        setState(() {});
                      },
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CircleAvatar(
                              radius: 13,
                              child: Icon(
                                  isActive
                                      ? Icons.arrow_upward_outlined
                                      : Icons.arrow_downward_outlined,
                                  size: 13)),
                          Text(
                            isActive ? 'Tăng dần' : 'Giảm dần',
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ))
                ])),
      ]),
    );
  }
}
