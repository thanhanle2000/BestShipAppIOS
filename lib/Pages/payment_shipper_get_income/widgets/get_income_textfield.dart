import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../Shared/blocs/theme/color.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/models/auth/auth_models.dart';
import '../../../Shared/models/auth/list_user/list_user_models.dart';
import '../../../Shared/preferences/preferences.dart';
import '../../../Shared/utils/app_utils.dart';
import '../../../Shared/widgets/base_widget/modal_bottom_sheet.dart';
import '../../order_scan/widgets/order_scan_button.dart';
import '../../order_scan/widgets/order_scan_list_item.dart';
import '../bloc/get_income_bloc.dart';
import '../bloc/get_income_event.dart';
import 'get_income_user.dart';

class GetIncomeTextField extends StatefulWidget {
  final GetIncomeBloc getIncomeBloc;
  final List<DataUser> dataUser;
  final Function(String) user;
  final void Function()? onPressed;

  const GetIncomeTextField(
      {super.key,
      required this.getIncomeBloc,
      required this.dataUser,
      required this.user,
      this.onPressed});

  @override
  State<GetIncomeTextField> createState() => _GetIncomeTextFieldState();
}

class _GetIncomeTextFieldState extends State<GetIncomeTextField> {
  final TextEditingController _userController = TextEditingController();
  String? name = Prefer.prefs?.getString('authenticationViewModel');
  late final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
  String nameUser = '';

  @override
  void initState() {
    super.initState();
    nameUser = username.userName!;
    getListUser(' ');
  }

  // Hàm lấy danh sách user
  // ignore: body_might_complete_normally_nullable
  Future<void>? getListUser(String key) {
    widget.getIncomeBloc.add(GetIncomeListUserEvent(key: key));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 35) / 2.8;
    final double itemWidth = size.width / 2;
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            color: Colors.amber,
            child: Column(children: [
              //Chọn user pickuper
              username.userType == 4
                  ? Container(
                      height: 40,
                      padding: const EdgeInsets.only(left: 5),
                      color: Colors.white,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Shipper: ',
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
                      text: 'Shipper: ',
                      ontap: () async {
                        await getListUser(' ');
                        await Future.delayed(const Duration(milliseconds: 300),
                            () async {
                          await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => ModalBottomSheet(
                                  title: '',
                                  height: (itemWidth / itemHeight),
                                  hasTitle: false,
                                  ui: Expanded(
                                      child: Column(children: [
                                    GetIncomeUser(
                                        controller: _userController,
                                        iconfx: Icons.clear,
                                        onpress: () async {
                                          _userController.clear();
                                          await getListUser(' ');
                                        },
                                        title: 'Nhập Người lấy hàng cần tìm',
                                        icon: Icons.supervisor_account_outlined,
                                        onFieldSubmitted: (value) async {
                                          await getListUser(
                                              _userController.text);
                                        }),
                                    Expanded(
                                        child: Scrollbar(
                                            child: ListView.builder(
                                                itemCount:
                                                    widget.dataUser.length,
                                                itemBuilder: (c, i) {
                                                  var e = widget.dataUser[i];
                                                  return OrderScanListItem(
                                                    onTap: () {
                                                      setState(() {
                                                        nameUser = e.userName!;
                                                        widget
                                                            .user(e.userName!);
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    name: e.userName!,
                                                  );
                                                })))
                                  ]))));
                        });
                      })
            ]),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        fromHexColor(Constants.COLOR_BUTTON)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)))),
                onPressed: widget.onPressed,
                child: const Text('Cập nhật',
                    style: TextStyle(fontSize: 15, color: Colors.white)))
          ])
        ]));
  }
}
