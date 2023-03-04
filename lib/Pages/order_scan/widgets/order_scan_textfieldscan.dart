import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/widgets/order_list_textfield_shop.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/widgets/order_scan_button.dart';
import 'package:flutter_app_best_shipp/Shared/blocs/theme/color.dart';
import 'package:intl/intl.dart';
import '../../../Shared/models/auth/auth_models.dart';
import '../../../Shared/models/auth/list_user/list_user_models.dart';
import '../../../Shared/models/order_scan/order_scan_list_shop.dart';
import '../../../Shared/preferences/preferences.dart';
import '../../../Shared/widgets/base_widget/modal_bottom_sheet.dart';
import '../bloc/order_scan_bloc.dart';
import '../bloc/order_scan_bloc_event.dart';
import 'order_scan_list_item.dart';

class OrderScanTextField extends StatefulWidget {
  final OrderScanBloc orderScanBloc;
  final List<DataUser> dataUser;
  final List<DataListShop> dataListShop;
  final Function(int) shopId;
  final Function(String) date;
  final Function(String) user;

  const OrderScanTextField(
      {super.key,
      required this.orderScanBloc,
      required this.dataUser,
      required this.dataListShop,
      required this.shopId,
      required this.date,
      required this.user});

  @override
  State<OrderScanTextField> createState() => _OrderScanTextFieldState();
}

class _OrderScanTextFieldState extends State<OrderScanTextField> {
  final TextEditingController _shopController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  String nameShop = 'Vui lòng chọn';
  String nameUser = 'Vui lòng chọn';
  DateTime dateNow = DateTime.now();
  String dateStart = "";

  String? name = Prefer.prefs?.getString('authenticationViewModel');
  @override
  void initState() {
    super.initState();
    _getListShop(' ');
    _getListUser(' ');
  }

  // hàm gọi bộ lịch
  void showDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: dateNow ?? DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2025))
        .then((value) {
      dateNow = value!;
      widget.date(DateFormat('yyyy-MM-dd').format(dateNow));
      changeTimeStart(DateFormat('yyyy-MM-dd').format(dateNow));
    });
  }

  void changeTimeStart(String newString) {
    setState(() {
      dateStart = newString;
    });
  }

  // Hàm lấy danh sách shop
  // ignore: body_might_complete_normally_nullable
  Future<void>? _getListShop(String key) {
    widget.orderScanBloc.add(OrderScanListShopEvent(key: key));
  }

  // Hàm lấy danh sách user
  // ignore: body_might_complete_normally_nullable
  Future<void>? _getListUser(String key) {
    widget.orderScanBloc.add(OrderScanListUserEvent(key: key));
  }

  @override
  Widget build(BuildContext context) {
    final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 35) / 2.8;
    final double itemWidth = size.width / 2;
    return Column(children: [
      // Chọn datetime
      OrderScanButton(
          text: 'Ngày lấy hàng: ',
          title: dateStart.isEmpty
              ? DateFormat('yyyy-MM-dd').format(DateTime.now())
              : dateStart,
          ontap: () {
            showDate(context);
          }),
      //Chọn danh mục shop
      OrderScanButton(
          text: 'Chọn shop: ',
          title: nameShop,
          ontap: () async {
            await _getListShop(' ');
            await Future.delayed(const Duration(milliseconds: 800), () async {
              await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ModalBottomSheet(
                      title: '',
                      height: (itemWidth / itemHeight),
                      HasTitle: false,
                      UI: Expanded(
                          child: Column(children: [
                        OrderListTextFieldShop(
                            controller: _shopController,
                            iconfx: Icons.clear,
                            onpress: () async {
                              _shopController.clear();
                              await _getListShop('');
                            },
                            title: 'Nhập vào Shop cần tìm',
                            icon: Icons.search_rounded,
                            onchanged: (value) async {
                              await _getListShop(value);
                            }),
                        Expanded(
                            child: Scrollbar(
                                child: ListView.builder(
                                    itemCount: widget.dataListShop.length,
                                    itemBuilder: (c, i) {
                                      var e = widget.dataListShop[i];
                                      return OrderScanListItem(
                                        onTap: () {
                                          setState(() {
                                            widget.shopId(e.id!);
                                            nameShop = e.name!;
                                            Navigator.pop(context);
                                          });
                                        },
                                        name: e.name!,
                                      );
                                    })))
                      ]))));
            });
          }),
      // End chọn danh mục shop
      //Chọn user pickuper
      username.userType == 4
          ? Container(
              height: 40,
              padding: const EdgeInsets.only(left: 5),
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Người lấy hàng: ',
                        style: TextStyle(
                            fontSize: 16, color: Colours.textDefault)),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text('${username.userName}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colours.textDefault)),
                    )
                  ]))
          : OrderScanButton(
              title: nameUser,
              text: 'Người lấy hàng: ',
              ontap: () async {
                await _getListUser(' ');
                await Future.delayed(const Duration(milliseconds: 800),
                    () async {
                  await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => ModalBottomSheet(
                          title: '',
                          height: (itemWidth / itemHeight),
                          HasTitle: false,
                          UI: Expanded(
                              child: Column(children: [
                            OrderListTextFieldShop(
                                controller: _userController,
                                iconfx: Icons.clear,
                                onpress: () async {
                                  _userController.clear();
                                  await _getListUser('');
                                },
                                title: 'Nhập Người lấy hàng cần tìm',
                                icon: Icons.supervisor_account_outlined,
                                onchanged: (value) async {
                                  await _getListUser(value);
                                }),
                            Expanded(
                                child: Scrollbar(
                                    child: ListView.builder(
                                        itemCount: widget.dataUser.length,
                                        itemBuilder: (c, i) {
                                          var e = widget.dataUser[i];
                                          return OrderScanListItem(
                                            onTap: () {
                                              setState(() {
                                                nameUser = e.userName!;
                                                widget.user(e.userName!);
                                                Navigator.pop(context);
                                              });
                                            },
                                            name: e.userName!,
                                          );
                                        })))
                          ]))));
                });
              })
    ]);
  }
}
