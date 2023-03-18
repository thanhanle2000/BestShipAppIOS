import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_get_income/bloc/get_income_event.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_get_income/bloc/get_income_state.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_get_income/widgets/get_income_body.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper_get_income/widgets/get_income_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/models/auth/auth_models.dart';
import '../../Shared/preferences/preferences.dart';
import '../../Shared/utils/app_loading.dart';
import '../../Shared/utils/app_utils.dart';
import '../../Shared/widgets/base_widget/custom_appbar.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';
import 'bloc/get_income_bloc.dart';

class GetIncome extends StatefulWidget {
  const GetIncome({super.key});

  @override
  State<GetIncome> createState() => _GetIncomeState();
}

class _GetIncomeState extends State<GetIncome> {
  late GetIncomeBloc getIncomeBloc;
  String? name = Prefer.prefs?.getString('authenticationViewModel');
  String userName = '';
  getUser(String user) {
    setState(() {
      userName = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getIncomeBloc = context.read<GetIncomeBloc>();
    getIncomeBloc.add(GetIncomeStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    final type = AuthenticationViewModel.fromJson(jsonDecode(name!));
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[100],
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: CustomAppbar(title: 'Thu nhập shipper')),
        body: BlocListener<GetIncomeBloc, GetIncomeState>(
            listener: (context, state) {
          // // Bật loading khi tải data
          if (!state.success) {
            app_loading(context);
          }
          // tắt loading
          else {
            Navigator.of(context).pop();
          }
          // khi không có dữ liệu sẽ trả về message fail
          if (state.status == 'fail') {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                snackBar_message('Không có dữ liệu.', "warning"),
              );
          }
        }, child: BlocBuilder<GetIncomeBloc, GetIncomeState>(
                builder: (context, state) {
          // ignore: unnecessary_null_comparison
          return SizedBox(
            child: Column(children: [
              GetIncomeTextField(
                  getIncomeBloc: getIncomeBloc,
                  dataUser: state.dataUser,
                  user: getUser,
                  onPressed: type.userType == 4
                      ? () {
                          getIncomeBloc.add(GetIncomeReloadEvent(
                              key: userName.isEmpty
                                  ? type.userName!
                                  : userName));
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              snackBar_message(
                                  'Cập nhật dữ liệu thành công.', "success"),
                            );
                        }
                      : () {
                          if (userName != '') {
                            getIncomeBloc.add(GetIncomeReloadEvent(
                                key: userName.isEmpty
                                    ? type.userName!
                                    : userName));
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                snackBar_message(
                                    'Cập nhật dữ liệu thành công.', "success"),
                              );
                          } else {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar_message(
                                  'Vui lòng chọn shipper.', "error"));
                          }
                        }),
              const SizedBox(height: 5),
              GetIncomeBody(title: 'Trong tháng', data: state.thirdData),
              const SizedBox(height: 5),
              GetIncomeBody(title: 'Hôm nay', data: state.firstData),
              const SizedBox(height: 5),
              GetIncomeBody(title: 'Hôm qua', data: state.secondData),
            ]),
          );
        })));
  }
}
