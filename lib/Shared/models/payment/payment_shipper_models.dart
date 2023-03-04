class PaymentShipperModels {
  bool? success;
  int? total;
  List<PaymentModels>? data;

  PaymentShipperModels({this.success, this.total, this.data});

  PaymentShipperModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    if (json['data'] != null) {
      data = <PaymentModels>[];
      json['data'].forEach((v) {
        data!.add(new PaymentModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentModels {
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
  String? paymentNote;

  PaymentModels(
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
      this.rowCreatedUser,
      this.paymentNote});

  PaymentModels.fromJson(Map<String, dynamic> json) {
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
    paymentNote = json['paymentNote'];
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
    data['paymentNote'] = this.paymentNote;
    return data;
  }
}
