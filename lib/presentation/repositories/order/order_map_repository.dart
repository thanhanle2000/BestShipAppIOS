import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../Pages/order_list_map/bloc/map_bloc.dart';
import '../../../Pages/order_list_map/widgets/order_list_map_modalbottomsheet.dart';
import '../../../Pages/order_list_map/widgets/order_list_map_order_bottom_sheet.dart';
import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/status/status_models.dart';

class MapRepository {
  Future<LatLng> getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation));
    return LatLng(position.latitude, position.longitude);
  }

  // xử lí lấy thông tin các điểm marker trên bản đồ
  Future<Marker> getInfoMaker(
      OrderModels data,
      MarkerId markerId,
      int index,
      StatusData statusModels,
      BuildContext contextMain,
      MapBloc mapBloc) async {
    var iconMaker =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    if (data.action_count == 1) {
      iconMaker =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    } else if (data.action_count! >= 2) {
      iconMaker =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }

    return Marker(
        markerId: markerId,
        position: LatLng(data.lat!, data.lng!),
        icon: iconMaker,
        infoWindow: InfoWindow(
            title: data.customerAddress,
            snippet: '${data.customerPhone!} - ${data.customerName!}',
            onTap: () async {
              await showModalBottomSheet(
                  context: contextMain,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Wrap(children: [
                        OrderListModalBottomSheet(
                            hasTitle: false,
                            lonData: data.lng,
                            latData: data.lat,
                            ui: OrderListMapInfoOrder(
                              data: data,
                              status: statusModels,
                              mapBloc: mapBloc,
                              contextMain: contextMain,
                            ))
                      ]));
            }));
  }

  // xử lí nạp data vào list marker
  final List<Future<Marker>> featureList = <Future<Marker>>[];
  Future<List<Marker>> runAllMarker(List<OrderModels> data,
      StatusData statusModels, BuildContext context, MapBloc mapBloc) async {
    int index = 0;
    for (var item in data) {
      if (item.lat != 0) {
        //  Chỉ lấy những item có lat va long
        featureList.add(getInfoMaker(item, MarkerId(index.toString()), index,
            statusModels, context, mapBloc));
        index++;
      }
    }
    var lstmaker = await Future.wait<Marker>(featureList);
    return lstmaker;
  }

  // gọi dữ liệu từ hàm tạo marker
  Future<List<Marker>> getDataMaker(List<OrderModels> data,
      StatusData statusModels, BuildContext context, MapBloc mapBloc) async {
    var lstmaker = await runAllMarker(data, statusModels, context, mapBloc);
    return lstmaker;
  }
}
