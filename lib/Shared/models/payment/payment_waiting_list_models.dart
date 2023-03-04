import 'package:flutter_app_best_shipp/Shared/models/order_list/order_list_models.dart';

class PaymentWaitingListModels {
  PaymentWaitingList? data;
  int? total;
  bool? success;

  PaymentWaitingListModels({this.data, this.total, this.success});

  PaymentWaitingListModels.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new PaymentWaitingList.fromJson(json['data'])
        : null;
    total = json['total'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['total'] = this.total;
    data['success'] = this.success;
    return data;
  }

  PaymentWaitingListModels copyWith(
      {PaymentWaitingList? data, int? total, bool? success}) {
    return PaymentWaitingListModels(data: data, total: total, success: success);
  }
}

class PaymentWaitingList {
  PaymentShipWaitPayment? paymentShipWaitPayment;
  List<OrderModels>? paymentShipOrders;

  PaymentWaitingList({this.paymentShipWaitPayment, this.paymentShipOrders});

  PaymentWaitingList.fromJson(Map<String, dynamic> json) {
    paymentShipWaitPayment = json['paymentShipWaitPayment'] != null
        ? new PaymentShipWaitPayment.fromJson(json['paymentShipWaitPayment'])
        : null;
    if (json['paymentShipOrders'] != null) {
      paymentShipOrders = <OrderModels>[];
      json['paymentShipOrders'].forEach((v) {
        paymentShipOrders!.add(new OrderModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentShipWaitPayment != null) {
      data['paymentShipWaitPayment'] = this.paymentShipWaitPayment!.toJson();
    }
    if (this.paymentShipOrders != null) {
      data['paymentShipOrders'] =
          this.paymentShipOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentShipWaitPayment {
  String? username;
  int? totalOrders;
  int? shipPrice;
  int? totalPrice;
  int? codPrice;
  int? totalRemain;
  int? receivedPrice;

  PaymentShipWaitPayment(
      {this.username,
      this.totalOrders,
      this.shipPrice,
      this.totalPrice,
      this.codPrice,
      this.totalRemain,
      this.receivedPrice});

  PaymentShipWaitPayment.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    totalOrders = json['totalOrders'];
    shipPrice = json['shipPrice'];
    totalPrice = json['totalPrice'];
    codPrice = json['codPrice'];
    totalRemain = json['totalRemain'];
    receivedPrice = json['receivedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['totalOrders'] = this.totalOrders;
    data['shipPrice'] = this.shipPrice;
    data['totalPrice'] = this.totalPrice;
    data['codPrice'] = this.codPrice;
    data['totalRemain'] = this.totalRemain;
    data['receivedPrice'] = this.receivedPrice;
    return data;
  }
}
