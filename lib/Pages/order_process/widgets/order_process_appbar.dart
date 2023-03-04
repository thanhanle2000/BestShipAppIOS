import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_process/bloc/order_process_bloc.dart';
import 'package:intl/intl.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/utils/app_utils.dart';
import '../../../Shared/widgets/base_widget/snackbar_message.dart';
import '../bloc/order_process_event.dart';
import 'order_process_filter_text.dart';

class OrderProcessAppbar extends StatefulWidget {
  final OrderProcessBloc orderBloc;
  final BuildContext blocContext;
  final String title;
  const OrderProcessAppbar(
      {super.key,
      required this.title,
      required this.orderBloc,
      required this.blocContext});

  @override
  State<OrderProcessAppbar> createState() => _OrderProcessAppbarState();
}

class _OrderProcessAppbarState extends State<OrderProcessAppbar> {
  String order = '';
  String orderCode = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
  }

  getOrder(String orders) {
    setState(() {
      order = orders;
    });
  }

  getOrderCode(String orderCodes) {
    setState(() {
      orderCode = orderCodes;
    });
  }

  getUserName(String userNames) {
    setState(() {
      userName = userNames;
    });
  }

  // reload lại trang
  // ignore: body_might_complete_normally_nullable
  Future<void>? getStarted(BuildContext contextBloc) {
    widget.orderBloc.add(OrderProcessFilterEvent(
        endDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        startDate: DateFormat('yyyy-MM-dd').format(DateTime(
            DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)),
        blocContext: contextBloc,
        processBloc: widget.orderBloc,
        customerName: '',
        customerPhone: '',
        orderCode: '',
        shopOrderCode: '',
        shopId: 0,
        orderStatus: [],
        SortType: ''));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios)),
      elevation: 0,
      backgroundColor: fromHexColor(Constants.COLOR_APPBAR),
      centerTitle: true,
      title: Text(widget.title),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
            onPressed: () async {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  snackBar_message('Cập nhật dữ liệu thành công.', "success"),
                );
              await getStarted(widget.blocContext);
            },
            icon: const Icon(Icons.loop_outlined)),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderProcessFilterTextField(
                        orderBloc: widget.orderBloc,
                        blocContext: widget.blocContext,
                        order: getOrder,
                        orderCode: getOrderCode,
                        userName: getUserName,
                      )),
            );
          },
          icon: (IsNullOrEmpty(order) &&
                  IsNullOrEmpty(orderCode) &&
                  IsNullOrEmpty(userName))
              ? const Icon(Icons.search_rounded)
              : Icon(
                  Icons.search_rounded,
                  color: fromHexColor(Constants.COLOR_BUTTON),
                ),
        )
      ],
    );
  }
}
