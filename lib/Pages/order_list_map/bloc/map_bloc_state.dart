part of '../../../Pages/order_list_map/bloc/map_bloc.dart';

class MapBlocState {
  final bool success;
  final String status;
  final String? message;
  final double latitude;
  final double longitude;
  final List<OrderModels>? orderList;
  final StatusData? statusModels;
  final List<Marker>? lstMarker;

  MapBlocState(
      {required this.orderList,
      required this.success,
      required this.status,
      required this.latitude,
      required this.longitude,
      required this.message,
      required this.statusModels,
      required this.lstMarker});

  //  Thành công
  factory MapBlocState.start(
      bool success,
      String status,
      double latitude,
      double longitude,
      List<OrderModels> orderList,
      StatusData statusModels,
      List<Marker> lstMarker) {
    return MapBlocState(
        success: success,
        status: status,
        latitude: latitude,
        longitude: longitude,
        message: null,
        orderList: orderList,
        statusModels: statusModels,
        lstMarker: lstMarker);
  }

  //  Thất bại
  factory MapBlocState.fail(String message) {
    return MapBlocState(
        success: true,
        status: "fail",
        latitude: 0,
        longitude: 0,
        message: message,
        orderList: null,
        statusModels: null,
        lstMarker: null);
  }

  // khởi tạo
  factory MapBlocState.empty() {
    return MapBlocState(
        success: false,
        status: "empty",
        latitude: 10.812218,
        longitude: 106.705971,
        message: null,
        orderList: null,
        statusModels: null,
        lstMarker: null);
  }
}
