import 'dart:convert';
import 'package:flutter_app_best_shipp/Shared/models/order_scan/order_scan_list_shop.dart';
import 'package:flutter_app_best_shipp/Shared/models/order_scan/order_scan_status.dart';
import '../../../Shared/constants/constants.dart';
import '../../../Shared/models/auth/auth_models.dart';
import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/order_scan/order_scan_total.dart';
import '../../../Shared/models/status/status_models.dart';
import '../../../Shared/preferences/preferences.dart';
import '../../../Shared/utils/httpRequest.dart';

class OrderMapServices {
  HttpRequestServices httpRequest;
  OrderMapServices({required this.httpRequest});
  // hàm lấy dữ liệu cho danh sách đơn hàng google map
  Future<OrderListModels> getDataMap(
      {List<int>? orderStatus,
      String? startDate,
      String? endDate,
      int? page}) async {
    var response = await httpRequest.HttpRequestPost(
        'Orders/Read',
        jsonEncode(<String, dynamic>{
          'orderStatus': orderStatus,
          'startDate': startDate,
          'endDate': endDate,
          'page': page,
          'pageSize': Constants.PAGESIZE_Map,
        }));

    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    final orderListJson = jsonDecode(response.body);
    return OrderListModels.fromJson(orderListJson);
  }

// hàm lấy dữ liệu cho danh sách đơn hàng google map
  Future<OrderListModels> getDataOrderScanFail(
      {int? shopId,
      List<int>? orderStatus,
      String? startDate,
      String? endDate,
      int? page}) async {
    var param = jsonEncode(
      <String, dynamic>{
        'shopId': shopId,
        'orderStatus': orderStatus,
        'startDate': startDate,
        'endDate': endDate,
        'page': page,
        'pageSize': Constants.PAGESIZE,
        "filterType": "order_scan_remain"
      },
    );
    var response = await httpRequest.HttpRequestPost('Orders/Read', param);
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    final orderListJson = jsonDecode(response.body);
    return OrderListModels.fromJson(orderListJson);
  }

// hàm lấy dữ liệu cho danh sách đơn hàng
  Future<OrderListModels> getDataOrderProcess(
      {int? page,
      String? startDate,
      String? endDate,
      String? customerPhone,
      String? customerName,
      String? orderCode,
      String? shopOrderCode,
      String? SortType,
      int? shopId,
      List<int>? orderStatus}) async {
    var param = jsonEncode(<String, dynamic>{
      'page': page,
      'startDate': startDate,
      'endDate': endDate,
      'customerPhone': customerPhone,
      'customerName': customerName,
      'orderCode': orderCode,
      'shopOrderCode': shopOrderCode,
      'SortType': SortType,
      'shopId': shopId,
      'orderStatus': orderStatus,
      'pageSize': Constants.PAGESIZE,
    });
    var response = await httpRequest.HttpRequestPost('Orders/Read', param);
    // print(param);
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }

    final orderListJson = jsonDecode(response.body);
    return OrderListModels.fromJson(orderListJson);
  }

  // get api status success
  Future<StatusModels> getSuccessStatusChange(
      int? shopId, String? code, String? shipper) async {
    var response = await httpRequest.HttpRequestPost(
        'Orders/Change_to_success_status',
        jsonEncode(<String, dynamic>{
          'shopId': shopId,
          'code': code,
          'shipper': shipper
        }));
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    var data = StatusModels.fromJson(jsonDecode(response.body));
    return data;
  }

  // get api list reason status cancel
  Future<StatusModels> getCancelStatusChange(int? shopId, String? code,
      String? shipper, int? CancelId, String? cancelReason) async {
    var response = await httpRequest.HttpRequestPost(
        'Orders/Report_cancel',
        jsonEncode(<String, dynamic>{
          'shopId': shopId,
          'code': code,
          'shipper': shipper,
          'CancelId': CancelId,
          'cancelReason': cancelReason
        }));
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    var data = StatusModels.fromJson(jsonDecode(response.body));
    return data;
  }

  // get api change action
  Future<StatusModels> getCancelStatusChangeAction(
      int? shopId,
      String? code,
      int? action_item_id,
      int? action_call_time,
      String? shipper,
      int? action_id,
      String? action_text) async {
    var response = await httpRequest.HttpRequestPost(
        'Orders/Add_action',
        jsonEncode(<String, dynamic>{
          'shopId': shopId,
          'code': code,
          'action_item_id': action_item_id,
          'action_call_time': action_call_time,
          'shipper': shipper,
          'action_id': action_id,
          'action_text': action_text
        }));
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    var data = StatusModels.fromJson(jsonDecode(response.body));
    return data;
  }

  // lấy thông tin total scan
  Future<OrderScanModels> getDataTotalScan(String? date, int? shopId) async {
    var response = await httpRequest.DioRequestGet(
        'OrdersReports/Order_Get_Pickuped_v2',
        {'date': date, 'shopId': shopId});
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    var data = OrderScanModels.fromJson(response.data);
    return data;
  }

  // lấy thông tin danh sách shop
  Future<OrderScanListShopModels> getDataListShop(String? key) async {
    var response = await httpRequest.DioRequestGet(
        // ignore: prefer_interpolation_to_compose_strings
        'basedata/shop_get_by_key?key=' + key!,
        {});
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    var data = OrderScanListShopModels.fromJson(response.data);
    return data;
  }

  // request order scan
  Future<OrderScanStatus> getDataScan(
      int? shopId, String? code, String? pickuper) async {
    String? name = Prefer.prefs?.getString('authenticationViewModel');
    final username = AuthenticationViewModel.fromJson(jsonDecode(name!));
    var param = {
      'shopId': shopId,
      'code': code,
      'pickuper': username.userType == 4 ? username.userName : pickuper
    };
    var response =
        await httpRequest.DioRequestGet('Orders/change_pickuper', param);
    if (response.statusCode != 200) {
      // Lỗi
      throw Exception('Invalid Credentials');
    }
    var data = OrderScanStatus.fromJson(response.data);
    return data;
  }
}
