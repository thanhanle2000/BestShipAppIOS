import 'dart:convert';
import 'package:flutter_app_best_shipp/Shared/models/payment/income_models.dart';
import 'package:flutter_app_best_shipp/Shared/utils/httpRequest.dart';
import 'package:flutter_app_best_shipp/presentation/services/payment/payment_services.dart';
import 'package:intl/intl.dart';
import '../../../Shared/models/auth/auth_models.dart';
import '../../../Shared/models/payment/confirm_payment_models.dart';
import '../../../Shared/models/payment/payment_shipper_detail_models.dart';
import '../../../Shared/models/payment/payment_shipper_models.dart';
import '../../../Shared/preferences/preferences.dart';

class PaymentRespository {
  final PaymentServices paymentServices;
  final int PaymentId;
  PaymentRespository(
      {PaymentServices? paymentServices, required this.PaymentId})
      : paymentServices = paymentServices ??
            (PaymentServices(httpRequest: HttpRequestServices()));

  final _dateEnd = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final _dateStart = DateFormat('yyyy-MM-dd').format(DateTime(
      DateTime.now().year, DateTime.now().month - 3, DateTime.now().day));
  String? name = Prefer.prefs?.getString('authenticationViewModel');
  // lấy danh sách thanh toán
  Future<PaymentShipperModels> getDataListPayment() async {
    return paymentServices.getDataListPayment(_dateStart, _dateEnd, 1);
  }

  // lấy thông tin chi tiết phiếu thanh toán
  Future<PaymentShipperDetailModels> getDataPaymentDetails() async {
    return paymentServices.getDataPaymentDetails(PaymentId);
  }

  // xác nhận đã thanh toán -> phiếu thanh toán
  Future<ConfirmPaymentModels> getConfirmPayment(int PaymentId) {
    return paymentServices.getConfirmPayment(PaymentId);
  }

  // lấy danh sách chi tiết đợi thanh toán
  Future<PaymentShipperDetailModels> getDataPaymentWaitingList() {
    final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
    return paymentServices.getDataPaymentWaitingList(username.userName);
  }

  // lấy thu nhập shipper
  Future<IncomeModels> getDataIncome(
      String userName, String startDate, String endDate) {
    return paymentServices.getDataIncome(userName, startDate, endDate);
  }
}
