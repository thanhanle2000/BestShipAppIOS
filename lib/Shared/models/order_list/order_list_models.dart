class OrderListModels {
  int? totalSuccsess;
  int? totalProcessing;
  int? totalOther;
  bool? success;
  int? total;
  String? message;
  List<OrderModels>? data;

  OrderListModels(
      {this.totalSuccsess,
      this.totalProcessing,
      this.totalOther,
      this.success,
      this.total,
      this.data,
      this.message});

  OrderListModels.fromJson(Map<String, dynamic> json) {
    totalSuccsess = json['total_succsess'];
    totalProcessing = json['total_processing'];
    totalOther = json['total_other'];
    success = json['success'];
    total = json['total'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderModels>[];
      json['data'].forEach((v) {
        data!.add(OrderModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_succsess'] = this.totalSuccsess;
    data['total_processing'] = this.totalProcessing;
    data['total_other'] = this.totalOther;
    data['success'] = this.success;
    data['total'] = this.total;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  OrderListModels copyWith({
    int? totalSuccsess,
    int? totalProcessing,
    int? totalOther,
    bool? success,
    int? total,
    String? message,
    List<OrderModels>? data,
  }) {
    return OrderListModels(
        totalSuccsess: totalSuccsess,
        totalProcessing: totalProcessing,
        totalOther: totalOther,
        success: success,
        total: total,
        message: message,
        data: data);
  }

  map(OrderModels Function(dynamic e) param0) {}
}

class OrderModels {
  BaseStatus? baseStatus;
  int? orderStatus;
  int? id;
  String? orderDate;
  String? orderCode;
  String? orderStatusNote;
  int? orderStatusCount;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  int? districtId;
  int? wardId;
  String? districtname;
  String? wardname;
  String? shopOrderProduct;
  String? shopNote;
  String? shopOrderCode;
  int? codPrice;
  int? shipPrice;
  int? totalPrice;
  String? pickuper;
  String? shipper;
  String? telesale;
  int? shopId;
  String? shopName;
  String? shopPhone;
  int? cancelId;
  int? action_count;
  bool? isCanceled;
  List<OrdersStatusHistory>? ordersStatusHistory;
  dynamic lng;
  dynamic lat;
  String? formatted_address;
  String? rowCreatedTime;
  String? rowLastUpdatedTime;
  OrderModels(
      {this.baseStatus,
      this.orderStatus,
      this.id,
      this.orderDate,
      this.orderCode,
      this.orderStatusNote,
      this.orderStatusCount,
      this.customerName,
      this.customerPhone,
      this.customerAddress,
      this.districtId,
      this.wardId,
      this.districtname,
      this.wardname,
      this.shopOrderProduct,
      this.shopNote,
      this.shopOrderCode,
      this.codPrice,
      this.shipPrice,
      this.totalPrice,
      this.pickuper,
      this.shipper,
      this.telesale,
      this.shopId,
      this.shopName,
      this.shopPhone,
      this.cancelId,
      this.action_count,
      this.isCanceled,
      this.ordersStatusHistory,
      this.lng,
      this.lat,
      this.formatted_address,
      this.rowCreatedTime,
      this.rowLastUpdatedTime});

  OrderModels.fromJson(Map<String, dynamic> json) {
    baseStatus = json['baseStatus'] != null
        ? new BaseStatus.fromJson(json['baseStatus'])
        : null;
    orderStatus = json['orderStatus'];
    id = json['id'];
    orderDate = json['orderDate'];
    orderCode = json['orderCode'];
    orderStatusNote = json['orderStatusNote'];
    orderStatusCount = json['orderStatusCount'];
    customerName = json['customerName'];
    customerPhone = json['customerPhone'];
    customerAddress = json['customerAddress'];
    districtId = json['districtId'];
    wardId = json['wardId'];
    districtname = json['districtname'];
    wardname = json['wardname'];
    shopOrderProduct = json['shopOrderProduct'];
    shopNote = json['shopNote'];
    shopOrderCode = json['shopOrderCode'];
    codPrice = json['codPrice'];
    shipPrice = json['shipPrice'];
    totalPrice = json['totalPrice'];
    pickuper = json['pickuper'];
    shipper = json['shipper'];
    telesale = json['telesale'];
    shopId = json['shopId'];
    shopName = json['shopName'];
    shopPhone = json['shopPhone'];
    cancelId = json['cancelId'];
    action_count = json['action_count'];
    isCanceled = json['isCanceled'];
    if (json['ordersStatusHistory'] != null) {
      ordersStatusHistory = <OrdersStatusHistory>[];
      json['ordersStatusHistory'].forEach((v) {
        ordersStatusHistory!.add(new OrdersStatusHistory.fromJson(v));
      });
    }
    lng = json['lng'];
    lat = json['lat'];
    formatted_address = json['formatted_address'];
    rowCreatedTime = json['rowCreatedTime'];
    rowLastUpdatedTime = json['rowLastUpdatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.baseStatus != null) {
      data['baseStatus'] = this.baseStatus!.toJson();
    }
    data['orderStatus'] = this.orderStatus;
    data['id'] = this.id;
    data['orderDate'] = this.orderDate;
    data['orderCode'] = this.orderCode;
    data['orderStatusNote'] = this.orderStatusNote;
    data['orderStatusCount'] = this.orderStatusCount;
    data['customerName'] = this.customerName;
    data['customerPhone'] = this.customerPhone;
    data['customerAddress'] = this.customerAddress;
    data['districtId'] = this.districtId;
    data['wardId'] = this.wardId;
    data['districtname'] = this.districtname;
    data['wardname'] = this.wardname;
    data['shopOrderProduct'] = this.shopOrderProduct;
    data['shopNote'] = this.shopNote;
    data['shopOrderCode'] = this.shopOrderCode;
    data['codPrice'] = this.codPrice;
    data['shipPrice'] = this.shipPrice;
    data['totalPrice'] = this.totalPrice;
    data['pickuper'] = this.pickuper;
    data['shipper'] = this.shipper;
    data['telesale'] = this.telesale;
    data['shopId'] = this.shopId;
    data['shopName'] = this.shopName;
    data['shopPhone'] = this.shopPhone;
    data['cancelId'] = this.cancelId;
    data['action_count'] = this.action_count;
    data['rowCreatedTime'] = this.rowCreatedTime;
    data['rowLastUpdatedTime'] = this.rowLastUpdatedTime;
    return data;
  }

  OrderModels copyWith({
    BaseStatus? baseStatus,
    int? orderStatus,
    int? id,
    String? orderDate,
    String? orderCode,
    String? orderStatusNote,
    int? orderStatusCount,
    String? customerName,
    String? customerPhone,
    String? customerAddress,
    int? districtId,
    int? wardId,
    String? districtname,
    String? wardname,
    String? shopOrderProduct,
    String? shopNote,
    String? shopOrderCode,
    int? codPrice,
    int? shipPrice,
    int? totalPrice,
    String? pickuper,
    String? shipper,
    String? telesale,
    int? shopId,
    String? shopName,
    String? shopPhone,
    int? cancelId,
    int? action_count,
    bool? isCanceled,
    List<OrdersStatusHistory>? ordersStatusHistory,
    double? lng,
    double? lat,
    String? formatted_address,
    String? rowCreatedTime,
    String? rowLastUpdatedTime,
  }) {
    return OrderModels(
        baseStatus: baseStatus,
        orderStatus: orderStatus,
        id: id,
        orderDate: orderDate,
        orderCode: orderCode,
        orderStatusNote: orderStatusNote,
        orderStatusCount: orderStatusCount,
        customerName: customerName,
        customerPhone: customerPhone,
        customerAddress: customerAddress,
        districtId: districtId,
        wardId: wardId,
        districtname: districtname,
        wardname: wardname,
        shopOrderProduct: shopOrderProduct,
        shopNote: shopNote,
        shopOrderCode: shopOrderCode,
        codPrice: codPrice,
        shipPrice: shipPrice,
        totalPrice: totalPrice,
        pickuper: pickuper,
        shipper: shipper,
        telesale: telesale,
        shopId: shopId,
        shopName: shopName,
        shopPhone: shopPhone,
        cancelId: cancelId,
        action_count: action_count,
        isCanceled: isCanceled,
        ordersStatusHistory: ordersStatusHistory,
        lat: lat,
        lng: lng,
        formatted_address: formatted_address,
        rowCreatedTime: rowCreatedTime,
        rowLastUpdatedTime: rowLastUpdatedTime);
  }
}

class BaseStatus {
  int? status;
  String? name;
  String? nameClass;

  BaseStatus({this.status, this.name, this.nameClass});

  BaseStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    nameClass = json['name_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.name;
    data['name_class'] = this.nameClass;
    return data;
  }
}

class OrdersStatusHistory {
  int? action_id;
  String? action_text;
  int? action_call_time;
  String? rowCreatedTime;

  OrdersStatusHistory(
      {this.action_id,
      this.action_text,
      this.action_call_time,
      this.rowCreatedTime});

  OrdersStatusHistory.fromJson(Map<String, dynamic> json) {
    action_id = json['action_id'];
    action_text = json['action_text'];
    action_call_time = json['action_call_time'];
    rowCreatedTime = json['rowCreatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action_id'] = this.action_id;
    data['action_text'] = this.action_text;
    data['action_call_time'] = this.action_call_time;
    data['rowCreatedTime'] = this.rowCreatedTime;
    return data;
  }
}
