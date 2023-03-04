import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/payment_shipper_screen.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_get_income/get_income_screen.dart';
import 'package:flutter_app_best_shipp/Shared/constants/constants.dart';
import 'package:flutter_app_best_shipp/Shared/utils/app_utils.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/payment/payment_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Pages/auth/bloc/authentication/authentication_bloc.dart';
import '../../../Pages/order_list_map/order_list_map_screen.dart';
import '../../../Pages/order_process/order_process_screen.dart';
import '../../../Pages/order_scan/order_scan_screen.dart';
import '../../../Pages/payment_waiting_list/payment_waiting_list_screen.dart';
import '../../../presentation/repositories/order/order_map_repository.dart';
import '../../../presentation/repositories/order/order_respository.dart';
import '../../../presentation/repositories/user/user_repository.dart';
import '../../blocs/theme/color.dart';
import '../../models/auth/auth_models.dart';
import '../../models/navigation.dart';
import '../../preferences/preferences.dart';
import 'nav_item.dart';

class NavDrawer extends StatefulWidget {
  final String currentRoute;
  const NavDrawer(this.currentRoute, {super.key});

  @override
  State<StatefulWidget> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  int currentSelectedIndex = -1;
  AuthenticationBloc? _authenBloc;
  String? name = Prefer.prefs?.getString('authenticationViewModel');

  @override
  void initState() {
    super.initState();
    // listen bloc event
    _authenBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  // xử lí log out
  void _onLogOutChange(context) {
    Navigator.of(context).pop();
    _authenBloc!.add(AuthenticationLoggedOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
    return SafeArea(
        child: Drawer(
            child: Container(
                color: Colors.grey[100],
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 40,
                                      child: Image.asset(
                                          'assets/images/Bestship_logo.png',
                                          height: 65,
                                          width: 65))),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(username.userName!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colours.textDefault)),
                                    const SizedBox(height: 5),
                                    const Text('Xin chào ',
                                        style: TextStyle(fontSize: 18))
                                  ])
                            ])),
                        const Divider(
                          height: 0.25,
                          color: Colors.black45,
                        ),
                        Container(
                          color: Theme.of(context).hintColor.withOpacity(.05),
                          child: ExpansionTile(
                              iconColor: fromHexColor(Constants.COLOR_BUTTON),
                              textColor: fromHexColor(Constants.COLOR_BUTTON),
                              collapsedBackgroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              leading: const Icon(Icons.assignment),
                              title: const Text('Quản lý đơn hàng',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              children: <Widget>[
                                ListTile(
                                    title: const Text('Quét đơn hàng',
                                        style: TextStyle(fontSize: 15)),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderScanScreen(
                                                      orderRespository:
                                                          OrderRespository(
                                                              ShopId: 0,
                                                              dateNow: ''),
                                                      userRepository:
                                                          UserRepository())));
                                    }),
                                ListTile(
                                    title: const Text(
                                        'Bản đồ danh sách đơn hàng',
                                        style: TextStyle(fontSize: 15)),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderListMapScreen(
                                                    mapRepository:
                                                        MapRepository(),
                                                    orderRespository:
                                                        OrderRespository(
                                                            ShopId: 0,
                                                            dateNow: ''))),
                                      );
                                    }),
                                ListTile(
                                    title: const Text('Danh sách đơn hàng',
                                        style: TextStyle(fontSize: 15)),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrderProcessScreen()));
                                    })
                              ]),
                        ),
                        const Divider(
                          height: 0.25,
                          color: Colors.black45,
                        ),
                        const SizedBox(height: 1),
                        Container(
                          color: Theme.of(context).hintColor.withOpacity(.05),
                          child: ExpansionTile(
                              iconColor: fromHexColor(Constants.COLOR_BUTTON),
                              textColor: fromHexColor(Constants.COLOR_BUTTON),
                              collapsedBackgroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              leading: const Icon(Icons.payment_rounded),
                              title: const Text('Thanh toán Shipper',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              children: <Widget>[
                                ListTile(
                                    title: const Text('Danh sách thanh toán',
                                        style: TextStyle(fontSize: 15)),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentShipperScreen(
                                                      paymentRespository:
                                                          PaymentRespository(
                                                              PaymentId: 0))));
                                    }),
                                ListTile(
                                    title: const Text(
                                        'Danh sách chờ thanh toán',
                                        style: TextStyle(fontSize: 15)),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentWaitingListScreen(
                                                      paymentRespository:
                                                          PaymentRespository(
                                                              PaymentId: 0))));
                                    }),
                                ListTile(
                                    title: const Text('Thu nhập Shipper',
                                        style: TextStyle(fontSize: 15)),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GetIcomeScreen(
                                                      paymentRespository:
                                                          PaymentRespository(
                                                              PaymentId: 0),
                                                      userRepository:
                                                          UserRepository())));
                                    })
                              ]),
                        ),
                        const Divider(height: 0.25, color: Colors.black45),
                        const SizedBox(height: 1),
                        Column(children: <Widget>[
                          navigationItem(context,
                              title: 'Đăng xuất',
                              icon: Icons.exit_to_app,
                              boxColor:
                                  Theme.of(context).hintColor.withOpacity(.05),
                              iconColor: Colors.red,
                              textStyle: navItemStyle, onTap: () {
                            _onLogOutChange(context);
                          })
                        ])
                      ]),
                      const Text('Version : 0.1',
                          style: TextStyle(fontSize: 15, color: Colors.grey))
                    ]))));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
