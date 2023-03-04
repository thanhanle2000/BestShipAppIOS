import '../../../Shared/models/auth/list_user/list_user_models.dart';
import '../../../Shared/models/order_scan/order_scan_list_shop.dart';
import '../../../Shared/models/order_scan/order_scan_status.dart';
import '../../../Shared/models/order_scan/order_scan_total.dart';

class OrderScanState {
  final bool success;
  final String status;
  final String? message;
  final OrderScanStatus orderScanStatus;
  final String? date;
  final int? shopId;
  final String? username;

  final DataTotalScan dataTotalScan;
  final List<DataListShop> dataListShop;
  final List<DataUser> dataUser;
  OrderScanState(
      {required this.success,
      required this.orderScanStatus,
      required this.status,
      required this.message,
      required this.date,
      required this.shopId,
      required this.username,
      required this.dataTotalScan,
      required this.dataListShop,
      required this.dataUser});

  //Thành công
  factory OrderScanState.start(
      bool success,
      OrderScanStatus orderScanStatus,
      String status,
      String date,
      int shopId,
      String username,
      DataTotalScan dataTotalScan,
      List<DataListShop> dataListShop,
      List<DataUser> dataUser) {
    return OrderScanState(
        success: success,
        orderScanStatus: orderScanStatus,
        status: status,
        date: date,
        shopId: shopId,
        username: username,
        message: null,
        dataListShop: dataListShop,
        dataTotalScan: dataTotalScan,
        dataUser: dataUser);
  }

  //Thất bại
  factory OrderScanState.fail(String message) {
    return OrderScanState(
        success: true,
        orderScanStatus: OrderScanStatus(),
        status: "fail",
        message: message,
        date: null,
        shopId: null,
        username: null,
        dataListShop: [],
        dataTotalScan: DataTotalScan(),
        dataUser: []);
  }

  //Khởi tạo
  factory OrderScanState.empty() {
    return OrderScanState(
        success: false,
        orderScanStatus: OrderScanStatus(),
        status: "empty",
        message: null,
        date: null,
        shopId: null,
        username: null,
        dataListShop: [],
        dataTotalScan: DataTotalScan(),
        dataUser: []);
  }
}

// check việc thay đổi trạng thái ở event so với state
class EventGetKeyListShop {
  String? keyListShop;
  EventGetKeyListShop({this.keyListShop});
}

class EventGetKeyUser {
  String? keyUser;
  EventGetKeyUser({this.keyUser});
}
