import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/bloc/order_scan_bloc.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/bloc/order_scan_bloc_state.dart';
import 'package:flutter_app_best_shipp/Shared/widgets/base_widget/custom_appbar.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/widgets/order_scan_textfield.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/widgets/order_scan_textfieldscan.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/widgets/order_scan_today.dart';
import 'package:flutter_app_best_shipp/Shared/constants/constants.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../Shared/models/auth/auth_models.dart';
import '../../Shared/preferences/preferences.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';
import '../../Shared/widgets/nav/nav_drawer.dart';
import '../order_list_map/widgets/order_list_button_confirm_filter.dart';
import 'bloc/order_scan_bloc_event.dart';

class OrderScan extends StatefulWidget {
  const OrderScan({super.key});

  @override
  State<OrderScan> createState() => _OrderScanState();
}

class _OrderScanState extends State<OrderScan> {
  late OrderScanBloc _oderScanBloc;
  final TextEditingController _barcodeController = TextEditingController();
  int ShopId = 0;
  String userName = '';
  String codeTemp = "";
  bool goodToGo = true;
  String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? name = Prefer.prefs?.getString('authenticationViewModel');
  @override
  void initState() {
    super.initState();
    _oderScanBloc = context.read<OrderScanBloc>();
    _oderScanBloc.add(OrderScanStartedEvent());
  }

  var options = const ScanOptions(
      android: AndroidOptions(
    useAutoFocus: true,
  ));
  getShopId(int shopId) {
    setState(() {
      ShopId = shopId;
    });
  }

  getDate(String date) {
    setState(() {
      dateNow = date;
    });
  }

  getUser(String user) {
    setState(() {
      userName = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.grey[200],
            // ignore: prefer_const_constructors
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(45.0),
                child: const CustomAppbar(title: 'Quét đơn hàng')),
            // ignore: prefer_const_constructors
            drawer: NavDrawer('/'),
            body: BlocListener<OrderScanBloc, OrderScanState>(
                listener: (context, state) {},
                child: BlocBuilder<OrderScanBloc, OrderScanState>(
                    builder: (context, state) {
                  return SingleChildScrollView(
                      child: Column(children: [
                    Scanfield(
                        title: 'Nhập và quét bằng máy Barcode',
                        icon: Icons.settings_remote_outlined,
                        controller: _barcodeController,
                        onpress: () {
                          _barcodeController.clear();
                        },
                        iconfx: Icons.clear,
                        onFocus: () => FocusScope.of(context).requestFocus(),
                        onSubmit: (value) async {
                          //truyền value vào api
                          var check = checkShopUserName(
                              ShopId,
                              username.userType == 4
                                  ? username.userName!
                                  : userName);
                          if (check.toString() == "OK") {
                            if (!IsNullOrEmpty(value)) {
                              await getOrderScanTextFieldEvent(value);
                            }
                            _barcodeController.clear();
                          } else {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                snackBar_message(check.toString(), "warning"),
                              );
                          }
                        }),
                    // hiển thị số liệu của các trạng thái quét hàng (chờ lấy hàng,quét mã,còn lại, tổng tiền)
                    // ignore: prefer_const_constructors
                    OrderScanToday(
                        date: dateNow,
                        dataTotalScan: state.dataTotalScan,
                        orderScanBloc: _oderScanBloc,
                        shopId: ShopId),
                    // chọn các thao tác thay đổi của bộ lọc (ngày,list : shop, user)
                    // ignore: prefer_const_constructors
                    OrderScanTextField(
                      orderScanBloc: _oderScanBloc,
                      dataListShop: state.dataListShop,
                      dataUser: state.dataUser,
                      shopId: getShopId,
                      date: getDate,
                      user: getUser,
                    ),
                    const SizedBox(height: 5),
                    //scan bằng cam điện thoại
                    OrderListButtonConfirmFilter(
                        color: fromHexColor(Constants.COLOR_BUTTON),
                        hw: 5,
                        title: 'Quét bằng Camera',
                        onpress: () async {
                          var check = checkShopUserName(
                              ShopId,
                              username.userType == 4
                                  ? username.userName!
                                  : userName);
                          if (check.toString() == "OK") {
                            scanQROpen();
                          } else {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar_message(
                                  check.toString(), "warning"));
                          }
                        }),
                    const SizedBox(height: 5),
                    OrderListButtonConfirmFilter(
                        color: fromHexColor(Constants.COLOR_BUTTON),
                        hw: 5,
                        title: 'Quét QR liên tục',
                        onpress: () async {
                          var check = checkShopUserName(
                              ShopId,
                              username.userType == 4
                                  ? username.userName!
                                  : userName);
                          if (check.toString() == "OK") {
                            scanContinuousDataEvent("QR");
                          } else {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar_message(
                                  check.toString(), "warning"));
                          }
                        }),
                    const SizedBox(height: 5),
                    OrderListButtonConfirmFilter(
                        color: fromHexColor(Constants.COLOR_BUTTON),
                        hw: 5,
                        title: 'Quét Barcode liên tục',
                        onpress: () async {
                          var check = checkShopUserName(
                              ShopId,
                              username.userType == 4
                                  ? username.userName!
                                  : userName);
                          if (check.toString() == "OK") {
                            scanContinuousDataEvent("Barcode");
                          } else {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                snackBar_message(check.toString(), "warning"),
                              );
                          }
                        })
                  ]));
                }))));
  }

  // Hàm xử lí order scan qua textfield
  // ignore: body_might_complete_normally_nullable, non_constant_identifier_names
  Future<void>? getOrderScanTextFieldEvent(String code) {
    _oderScanBloc.add(OrderScanTextFieldEvent(
        date: dateNow, shopId: ShopId, code: code, pickuper: userName));
  }

  // Hàm xử lí order scan qua QR
  // ignore: non_constant_identifier_names, body_might_complete_normally_nullable
  Future<void>? getOrderScanQREvent(String code, BuildContext context) {
    _oderScanBloc.add(OrderScanQREvent(
        date: dateNow, shopId: ShopId, code: code, pickuper: userName));
  }

  // Hàm xử lí scan qr liên tục
  // ignore: body_might_complete_normally_nullable
  Future<void>? getOrderScanContinuousQREvent(String code) {
    _oderScanBloc.add(OrderScanContinuousQREvent(
        date: dateNow, shopId: ShopId, code: code, pickuper: userName));
  }

  // Quét mã vạch đang cập nhật
  Future<void>? scanContinuousDataEvent(String scanMode) async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver('#ff6666', 'Thoát', true,
            scanMode == "QR" ? ScanMode.QR : ScanMode.BARCODE)
        ?.listen((barcode) async {
      if (!IsNullOrEmpty(barcode)) {
        // check barcode quet hay chua
        if (codeTemp != barcode) {
          codeTemp = barcode;
          getOrderScanContinuousQREvent(barcode);
        }
      }
    });
  }

  // gọi camera scan qr & barcode đơn
  Future scanQROpen() async {
    ScanResult qrScanResult = await BarcodeScanner.scan(options: options);
    // ignore: no_leading_underscores_for_local_identifiers
    String _qrResult = qrScanResult.rawContent;
    if (!IsNullOrEmpty(_qrResult)) {
      // ignore: use_build_context_synchronously
      await getOrderScanQREvent(_qrResult, context);
      // ignore: use_build_context_synchronously
      await scanQROpen();
    }
  }

  // check đã có shop & user chưa
  String? checkShopUserName(int shopId, String userName) {
    if (shopId == 0) {
      return "Vui lòng chọn shop";
    }
    if (IsNullOrEmpty(userName)) {
      return "Vui lòng chọn người lấy hàng";
    }
    return "OK";
  }
}
