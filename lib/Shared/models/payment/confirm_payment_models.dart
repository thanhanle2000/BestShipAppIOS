class ConfirmPaymentModels {
  int? total;
  bool? success;
  String? message;

  ConfirmPaymentModels({this.total, this.success, this.message});

  ConfirmPaymentModels.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
