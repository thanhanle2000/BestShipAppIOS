import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/payment/payment_shipper_detail_models.dart';

class PaymentShipperDetailsState {
  final bool success;
  final String status;
  final String? message;
  final PaymentShip paymentShip;
  final List<OrderModels> orderModel;

  PaymentShipperDetailsState(
      {required this.success,
      required this.status,
      required this.message,
      required this.paymentShip,
      required this.orderModel});

  // khởi tạo
  factory PaymentShipperDetailsState.empty() {
    return PaymentShipperDetailsState(
        success: false,
        status: "empty",
        message: null,
        paymentShip: PaymentShip(),
        orderModel: []);
  }

  // start
  factory PaymentShipperDetailsState.start(bool success, String status,
      PaymentShip paymentShip, List<OrderModels> orderModel) {
    return PaymentShipperDetailsState(
        success: success,
        status: status,
        message: null,
        paymentShip: paymentShip,
        orderModel: orderModel);
  }

  //fail
  factory PaymentShipperDetailsState.fail(String message) {
    return PaymentShipperDetailsState(
        success: true,
        status: "fail",
        message: message,
        paymentShip: PaymentShip(),
        orderModel: []);
  }
}
