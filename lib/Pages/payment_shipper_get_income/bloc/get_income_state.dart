import 'package:flutter_app_best_shipp/Shared/models/payment/income_models.dart';

import '../../../Shared/models/auth/list_user/list_user_models.dart';

class GetIncomeState {
  final bool success;
  final String status;
  final String? message;
  final Income firstData;
  final Income secondData;
  final Income thirdData;
  final List<DataUser> dataUser;

  GetIncomeState(
      {required this.success,
      required this.status,
      required this.message,
      required this.firstData,
      required this.secondData,
      required this.thirdData,
      required this.dataUser});

  // khởi tạo
  factory GetIncomeState.empty() {
    return GetIncomeState(
        success: false,
        status: "empty",
        message: null,
        firstData: Income(),
        secondData: Income(),
        thirdData: Income(),
        dataUser: []);
  }

  // start
  factory GetIncomeState.start(bool success, String status, Income firstData,
      Income secondData, Income thirdData, List<DataUser> dataUser) {
    return GetIncomeState(
        success: success,
        status: status,
        message: null,
        firstData: firstData,
        secondData: secondData,
        thirdData: thirdData,
        dataUser: dataUser);
  }

  // fail
  factory GetIncomeState.fail(String message) {
    return GetIncomeState(
        success: true,
        status: "fail",
        message: message,
        firstData: Income(),
        secondData: Income(),
        thirdData: Income(),
        dataUser: []);
  }
}
