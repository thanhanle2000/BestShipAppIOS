import 'dart:convert';
import 'package:flutter_app_best_shipp/Shared/models/payment/payment_shipper_models.dart';
import 'package:flutter_app_best_shipp/Shared/utils/httpRequest.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/models/payment/confirm_payment_models.dart';
import '../../../Shared/models/payment/income_models.dart';
import '../../../Shared/models/payment/payment_shipper_detail_models.dart';

class PaymentServices {
  HttpRequestServices httpRequest;
  PaymentServices({required this.httpRequest});

  // Hàm lấy danh sách thanh toán cho shipper
  Future<PaymentShipperModels> getDataListPayment(
      String? startDate, String? endDate, int? page) async {
    var param = jsonEncode(<String, dynamic>{
      'startDate': startDate,
      'endDate': endDate,
      'page': page,
      'pageSize': Constants.PAGESIZE_Payment,
    });
    var response = await httpRequest.HttpRequestPost('PaymentShip/Read', param);
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    final orderListJson = jsonDecode(response.body);

    return PaymentShipperModels.fromJson(orderListJson);
  }

  // Hàm lấythu nhập cho shipper
  Future<IncomeModels> getDataIncome(
      String? Shipper, String? startDate, String? endDate) async {
    var param = jsonEncode(<String, dynamic>{
      'Shipper': Shipper,
      'startDate': startDate,
      'endDate': endDate,
    });
    var response = await httpRequest.HttpRequestPost(
      'PaymentShip/PaymentShip_GetIncome',
      param,
    );
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    final orderListJson = jsonDecode(response.body);

    return IncomeModels.fromJson(orderListJson);
  }

  // lấy thông tin chi tiết phiếu thanh toán
  Future<PaymentShipperDetailModels> getDataPaymentDetails(
      int? PaymentId) async {
    var response = await httpRequest.DioRequestGet(
        'PaymentShip/PaymentShipPrint', {'PaymentId': PaymentId});
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    var data = PaymentShipperDetailModels.fromJson(response.data);
    return data;
  }

  // xác nhận đã thanh toán -> phiếu thanh toán
  Future<ConfirmPaymentModels> getConfirmPayment(int? PaymentId) async {
    var response = await httpRequest.DioRequestGet(
        'PaymentShip/PaymentShip_Confirm', {'PaymentId': PaymentId});
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    var data = ConfirmPaymentModels.fromJson(response.data);
    return data;
  }

  // lấy danh sách chi tiết đợi thanh toán
  Future<PaymentShipperDetailModels> getDataPaymentWaitingList(
      String? shipper) async {
    var param = jsonEncode(<String, dynamic>{'shipper': shipper});
    var response = await httpRequest.HttpRequestGet(
        'PaymentShip/PaymentShipList_GetWaitPayment?shipper=$shipper', param);
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    final data = jsonDecode(response.body);
    return PaymentShipperDetailModels.fromJson(data);
  }
}
