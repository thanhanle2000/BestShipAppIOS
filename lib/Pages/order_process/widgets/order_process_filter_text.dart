import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/blocs/theme/color.dart';
import 'package:flutter_app_best_shipp/Shared/utils/app_utils.dart';
import 'package:flutter_app_best_shipp/Shared/widgets/base_widget/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Shared/constants/constants.dart';
import '../../../Shared/preferences/preferences.dart';
import '../../../Shared/widgets/base_widget/snackbar_message.dart';
import '../../payment_shipper/widgets/payment_shipper_confirm.dart';
import '../bloc/order_process_bloc.dart';
import '../bloc/order_process_event.dart';
import 'order_process_textformfields.dart';

class OrderProcessFilterTextField extends StatefulWidget {
  final OrderProcessBloc orderBloc;
  final BuildContext blocContext;
  final Function(String) order;
  final Function(String) orderCode;
  final Function(String) userName;

  const OrderProcessFilterTextField(
      {super.key,
      required this.orderBloc,
      required this.order,
      required this.orderCode,
      required this.userName,
      required this.blocContext});

  @override
  State<OrderProcessFilterTextField> createState() =>
      _OrderProcessFilterTextFieldState();
}

class _OrderProcessFilterTextFieldState
    extends State<OrderProcessFilterTextField> {
  TextEditingController orderController = TextEditingController();
  TextEditingController orderCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String? orderCode = Prefer.prefs?.getString('order');
  String? shopOrderCode = Prefer.prefs?.getString('orderCode');
  String? userName = Prefer.prefs?.getString('nameUser');

  @override
  void dispose() {
    orderController.dispose();
    orderCodeController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: CustomAppbar(
            title: 'Tìm kiếm đơn hàng',
          )),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 5),
                  child: Text(
                    'Tìm kiếm theo mã vận đơn:',
                    style: TextStyle(fontSize: 16, color: Colours.classicText),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: OrderProcessTextFormFields(
                    iconData: Icons.filter_frames,
                    title: 'Nhập vào mã vận đơn',
                    controller: orderController,
                    onSubmit: (value) async {},
                    onPressed: () async {
                      orderController.clear();
                    },
                    onTap: () async {
                      final value = await FlutterClipboard.paste();
                      orderController.text = value;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 5),
                  child: Text(
                    'Tìm kiếm theo mã đơn hàng:',
                    style: TextStyle(fontSize: 16, color: Colours.classicText),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: OrderProcessTextFormFields(
                    iconData: Icons.assignment_late_rounded,
                    title: 'Nhập vào mã đơn hàng',
                    controller: orderCodeController,
                    onSubmit: (value) {},
                    onPressed: () async {
                      orderCodeController.clear();
                    },
                    onTap: () async {},
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 5),
                  child: Text(
                    'Tìm kiếm theo tên khách hàng:',
                    style: TextStyle(fontSize: 16, color: Colours.classicText),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: OrderProcessTextFormFields(
                    iconData: Icons.supervisor_account,
                    title: 'Nhập vào tên khách hàng',
                    controller: nameController,
                    onSubmit: (value) {},
                    onPressed: () async {
                      nameController.clear();
                    },
                    onTap: () async {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PaymentShipperConfirm(
                  onpress: () async {
                    if (IsNullOrEmpty(orderController.text) &&
                        IsNullOrEmpty(orderCodeController.text) &&
                        IsNullOrEmpty(nameController.text)) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          snackBar_message(
                              'Vui lòng kiểm tra dữ liệu nhập vào.', "error"),
                        );
                    } else {
                      widget.order(orderController.text);
                      widget.orderCode(orderCodeController.text);
                      widget.userName(nameController.text);
                      await getEventTextField(
                          orderController.text,
                          orderCodeController.text,
                          nameController.text,
                          widget.blocContext);
                      onSaved(orderController.text, orderCodeController.text,
                          nameController.text);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                  title: 'Xác nhận',
                  colorString: Constants.COLOR_BUTTON,
                  lr: 40,
                ),
                PaymentShipperConfirm(
                  onpress: () {
                    onSaved('', '', '');
                    widget.order('');
                    widget.orderCode('');
                    widget.userName('');
                    Navigator.pop(context);
                  },
                  title: 'Đóng',
                  colorString: Constants.COLOR_APPBAR,
                  lr: 50,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // sự kiện lọc theo textfiled
  // ignore: body_might_complete_normally_nullable
  Future<void>? getEventTextField(String order, String orderCode,
      String customerName, BuildContext context) {
    widget.orderBloc.add(OrderProcessFilterTextFieldEvent(
        customerName: customerName,
        orderCode: order,
        shopOrderCode: orderCode,
        blocContext: context,
        processBloc: widget.orderBloc));
  }

  void onSaved(String order, String orderCode, String nameUser) async {
    Prefer.prefs = await SharedPreferences.getInstance();
    Prefer.prefs!.setString('order', order);
    Prefer.prefs!.setString('orderCode', orderCode);
    Prefer.prefs!.setString('nameUser', nameUser);
  }
}
