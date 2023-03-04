class IncomeModels {
  bool? success;
  Income? data;

  IncomeModels({this.success, this.data});

  IncomeModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Income.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Income {
  String? userName;
  int? totalOrder;
  int? totalProcess;
  int? totalSuccess;
  int? receivedPrice;

  Income(
      {this.userName,
      this.totalOrder,
      this.totalProcess,
      this.totalSuccess,
      this.receivedPrice});

  Income.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    totalOrder = json['totalOrder'];
    totalProcess = json['totalProcess'];
    totalSuccess = json['totalSuccess'];
    receivedPrice = json['receivedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['totalOrder'] = this.totalOrder;
    data['totalProcess'] = this.totalProcess;
    data['totalSuccess'] = this.totalSuccess;
    data['receivedPrice'] = this.receivedPrice;
    return data;
  }
}
