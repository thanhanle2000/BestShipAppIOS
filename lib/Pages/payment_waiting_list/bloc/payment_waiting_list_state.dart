import 'package:flutter_app_best_shipp/Shared/models/order_list/order_list_models.dart';
import 'package:flutter_app_best_shipp/Shared/models/payment/payment_shipper_detail_models.dart';

class PaymentWaitingListState {
  final bool success;
  final String status;
  final String? message;
  final PaymentShip paymentShip;
  final List<OrderModels> lstOrder;

  PaymentWaitingListState(
      {required this.success,
      required this.status,
      required this.message,
      required this.paymentShip,
      required this.lstOrder});

  // empty
  factory PaymentWaitingListState.empty() {
    return PaymentWaitingListState(
        success: false,
        status: "empty",
        message: null,
        paymentShip: PaymentShip(),
        lstOrder: []);
  }

  // start
  factory PaymentWaitingListState.start(bool success, String status,
      PaymentShip paymentShip, List<OrderModels> orderModel) {
    return PaymentWaitingListState(
        success: success,
        status: status,
        message: null,
        paymentShip: paymentShip,
        lstOrder: orderModel);
  }

  // fail
  factory PaymentWaitingListState.fail(String message) {
    return PaymentWaitingListState(
        success: true,
        status: "fail",
        message: message,
        paymentShip: PaymentShip(),
        lstOrder: []);
  }
}
