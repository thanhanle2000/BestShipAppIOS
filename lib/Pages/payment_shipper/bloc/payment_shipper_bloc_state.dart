import 'package:flutter_app_best_shipp/Shared/models/payment/payment_shipper_models.dart';

class PaymentShipperState {
  final bool success;
  final String status;
  final String? message;
  final int total;
  final List<PaymentModels> data;
  final bool successStatus;
  final String? messStatus;

  PaymentShipperState(
      {required this.success,
      required this.status,
      required this.message,
      required this.total,
      required this.data,
      required this.successStatus,
      required this.messStatus});

  // khởi tạo
  factory PaymentShipperState.empty() {
    return PaymentShipperState(
        success: false,
        status: "empty",
        message: null,
        total: 0,
        data: [],
        successStatus: false,
        messStatus: null);
  }

  // start
  factory PaymentShipperState.start(bool success, String status, int total,
      List<PaymentModels> data, bool successStatus, String messStatus) {
    return PaymentShipperState(
        success: success,
        status: status,
        message: null,
        total: total,
        data: data,
        successStatus: successStatus,
        messStatus: messStatus);
  }

  // fail
  factory PaymentShipperState.fail(String message) {
    return PaymentShipperState(
        success: true,
        status: "fail",
        message: message,
        total: 0,
        data: [],
        successStatus: false,
        messStatus: null);
  }
}
