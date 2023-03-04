import 'package:flutter_app_best_shipp/Shared/models/order_scan/order_scan_list_shop.dart';
import 'package:flutter_app_best_shipp/Shared/models/order_scan/order_scan_total.dart';
import 'package:intl/intl.dart';
import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/order_scan/order_scan_status.dart';
import '../../../Shared/models/status/status_models.dart';
import '../../../Shared/utils/httpRequest.dart';
import '../../services/order/order_map_services.dart';

class OrderRespository {
  final OrderMapServices orderScanServices;
  // ignore: non_constant_identifier_names
  final int ShopId;
  final String dateNow;
  OrderRespository(
      {OrderMapServices? orderScanServices,
      required this.ShopId,
      required this.dateNow})
      : orderScanServices = orderScanServices ??
            OrderMapServices(httpRequest: HttpRequestServices());
  final _dateEnd = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final _dateStart = DateFormat('yyyy-MM-dd').format(DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day));

  // hàm xử lí lấy data cho danh sách marker
  // ignore: non_constant_identifier_names
  Future<OrderListModels> getDataForMap() async {
    return orderScanServices.getDataMap(
        orderStatus: [4], startDate: _dateStart, endDate: _dateEnd, page: 1);
  }

  // hàm xử lí lấy danh sách order scan fail
  Future<OrderListModels> getDataOrderScanFail(int page) async {
    return orderScanServices.getDataOrderScanFail(
        shopId: ShopId,
        orderStatus: [1],
        startDate: dateNow,
        endDate: dateNow,
        page: page);
  }

  // hàm lấy dữ liệu đơn hàng chưa quét
  Future<OrderListModels> getData(int page) async {
    return orderScanServices.getDataOrderScanFail(
        shopId: ShopId,
        orderStatus: [1],
        startDate: dateNow,
        endDate: dateNow,
        page: page);
  }

  // hàm xử lí dữ liệu danh sách đơn hàng
  Future<OrderListModels> getDataOrderProcess(int page) {
    return orderScanServices.getDataOrderProcess(
        shopId: 0,
        orderStatus: [],
        startDate: _dateStart,
        endDate: _dateEnd,
        page: page);
  }

  // sự kiện lọc
  Future<OrderListModels> filterEvent(
      int? page,
      String? startDate,
      String? endDate,
      String? customerPhone,
      String? customerName,
      String? orderCode,
      String? shopOrderCode,
      String? SortType,
      int? shopId,
      List<int>? orderStatus) {
    return orderScanServices.getDataOrderProcess(
        page: page,
        startDate: startDate,
        endDate: endDate,
        customerPhone: customerPhone,
        customerName: customerName,
        orderCode: orderCode,
        shopOrderCode: shopOrderCode,
        SortType: SortType,
        shopId: shopId,
        orderStatus: orderStatus);
  }

  // lấy dữ liệu cho màn hình xử lí đơn hàng cho shipper
  Future<OrderListModels> orderProcessData(
      int? page,
      String? customerPhone,
      String? customerName,
      String? orderCode,
      String? shopOrderCode,
      String? SortType) {
    return orderScanServices.getDataOrderProcess(
        page: page,
        startDate: _dateStart,
        endDate: _dateEnd,
        customerPhone: customerPhone,
        customerName: customerName,
        orderCode: orderCode,
        shopOrderCode: shopOrderCode,
        SortType: SortType,
        shopId: 0,
        orderStatus: [4, 8]);
  }

  // hàm xử lí sự kiện chuyển đơn thành công
  // ignore: non_constant_identifier_names
  Future<StatusModels> getDataSuccess(
      int shopId, String code, String shipper) async {
    return orderScanServices.getSuccessStatusChange(shopId, code, shipper);
  }

  // hàm xử lí sự kiện lí do hủy đơn
  Future<StatusModels> getDataCancel(int shopId, String code, String shipper,
      int CancelId, String cancelReason) async {
    return orderScanServices.getCancelStatusChange(
        shopId, code, shipper, CancelId, cancelReason);
  }

  // hàm xử lí sự kiện thay đổi trạng thái action đơn hàng
  Future<StatusModels> getDataAction(
      int shopId,
      String code,
      int action_item_id,
      int action_call_time,
      String shipper,
      int action_id,
      String action_text) async {
    return orderScanServices.getCancelStatusChangeAction(shopId, code,
        action_item_id, action_call_time, shipper, action_id, action_text);
  }

  // hàm lấy total scan
  Future<OrderScanModels> getDataTotalScan(String date, int shopId) async {
    return orderScanServices.getDataTotalScan(date, shopId);
  }

  // hàm lấy danh sách shop
  Future<OrderScanListShopModels> getDataListShop(String key) async {
    return orderScanServices.getDataListShop(key);
  }

  // request order scan
  Future<OrderScanStatus> getDataScan(
      int? shopId, String? code, String? pickuper) async {
    return orderScanServices.getDataScan(shopId, code, pickuper);
  }
}
