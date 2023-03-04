class OrderScanModels {
  bool? success;
  DataTotalScan? data;
  String? message;

  OrderScanModels({this.success, this.data, this.message});

  OrderScanModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? new DataTotalScan.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class DataTotalScan {
  int? orderTotal;
  int? orderTotalPickuped;
  int? orderTotalRemain;
  int? totalCODPickuped;
  int? totalShipPickuped;
  int? totalRemainPickuped;

  DataTotalScan(
      {this.orderTotal,
      this.orderTotalPickuped,
      this.orderTotalRemain,
      this.totalCODPickuped,
      this.totalShipPickuped,
      this.totalRemainPickuped});

  DataTotalScan.fromJson(Map<String, dynamic> json) {
    orderTotal = json['orderTotal'];
    orderTotalPickuped = json['orderTotalPickuped'];
    orderTotalRemain = json['orderTotalRemain'];
    totalCODPickuped = json['totalCODPickuped'];
    totalShipPickuped = json['totalShipPickuped'];
    totalRemainPickuped = json['totalRemainPickuped'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderTotal'] = this.orderTotal;
    data['orderTotalPickuped'] = this.orderTotalPickuped;
    data['orderTotalRemain'] = this.orderTotalRemain;
    data['totalCODPickuped'] = this.totalCODPickuped;
    data['totalShipPickuped'] = this.totalShipPickuped;
    data['totalRemainPickuped'] = this.totalRemainPickuped;
    return data;
  }
}
