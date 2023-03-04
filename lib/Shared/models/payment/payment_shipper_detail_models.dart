import '../order_list/order_list_models.dart';

class PaymentShipperDetailModels {
  PaymentShipperModel? data;
  int? total;
  bool? success;

  PaymentShipperDetailModels({this.data, this.total, this.success});

  PaymentShipperDetailModels.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new PaymentShipperModel.fromJson(json['data'])
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

  PaymentShipperDetailModels copyWith(
      {PaymentShipperModel? data, int? total, bool? success}) {
    return PaymentShipperDetailModels(
        data: data, total: total, success: success);
  }
}

class PaymentShipperModel {
  PaymentShip? paymentShip;
  List<OrderModels>? paymentShipOrders;

  PaymentShipperModel({this.paymentShip, this.paymentShipOrders});

  PaymentShipperModel.fromJson(Map<String, dynamic> json) {
    paymentShip = json['paymentShip'] != null
        ? new PaymentShip.fromJson(json['paymentShip'])
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
    if (this.paymentShip != null) {
      data['paymentShip'] = this.paymentShip!.toJson();
    }
    if (this.paymentShipOrders != null) {
      data['paymentShipOrders'] =
          this.paymentShipOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  PaymentShipperModel copyWith(
      {PaymentShip? paymentShip, List<OrderModels>? paymentShipOrders}) {
    return PaymentShipperModel(
        paymentShip: paymentShip, paymentShipOrders: paymentShipOrders);
  }
}

class PaymentShip {
  int? id;
  String? paymentDate;
  String? typeName;
  String? paymentName;
  String? userName;
  int? totalOrders;
  int? shipPrice;
  int? totalPrice;
  int? receivedPrice;
  int? totalCOD;
  int? totalRemain;
  bool? isConfirm;
  String? rowCreatedTime;
  String? rowCreatedUser;

  PaymentShip(
      {this.id,
      this.paymentDate,
      this.typeName,
      this.paymentName,
      this.userName,
      this.totalOrders,
      this.shipPrice,
      this.totalPrice,
      this.receivedPrice,
      this.totalCOD,
      this.totalRemain,
      this.isConfirm,
      this.rowCreatedTime,
      this.rowCreatedUser});

  PaymentShip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentDate = json['paymentDate'];
    typeName = json['typeName'];
    paymentName = json['paymentName'];
    userName = json['userName'];
    totalOrders = json['totalOrders'];
    shipPrice = json['shipPrice'];
    totalPrice = json['totalPrice'];
    receivedPrice = json['receivedPrice'];
    totalCOD = json['totalCOD'];
    totalRemain = json['totalRemain'];
    isConfirm = json['isConfirm'];
    rowCreatedTime = json['rowCreatedTime'];
    rowCreatedUser = json['rowCreatedUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['paymentDate'] = this.paymentDate;
    data['typeName'] = this.typeName;
    data['paymentName'] = this.paymentName;
    data['userName'] = this.userName;
    data['totalOrders'] = this.totalOrders;
    data['shipPrice'] = this.shipPrice;
    data['totalPrice'] = this.totalPrice;
    data['receivedPrice'] = this.receivedPrice;
    data['totalCOD'] = this.totalCOD;
    data['totalRemain'] = this.totalRemain;
    data['isConfirm'] = this.isConfirm;
    data['rowCreatedTime'] = this.rowCreatedTime;
    data['rowCreatedUser'] = this.rowCreatedUser;
    return data;
  }
}
