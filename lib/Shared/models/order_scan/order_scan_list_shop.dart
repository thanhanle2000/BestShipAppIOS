class OrderScanListShopModels {
  List<DataListShop>? data;
  int? total;
  int? id;
  bool? success;
  int? statusCode;

  OrderScanListShopModels(
      {this.data, this.total, this.id, this.success, this.statusCode});

  OrderScanListShopModels.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataListShop>[];
      json['data'].forEach((v) {
        data!.add(new DataListShop.fromJson(v));
      });
    }
    total = json['total'];
    id = json['id'];
    success = json['success'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['id'] = this.id;
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class DataListShop {
  int? id;
  String? name;

  DataListShop({this.id, this.name});

  DataListShop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
