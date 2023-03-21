import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Shared/constants/constants.dart';
import 'package:flutter_app_best_shipp/Shared/utils/app_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import '../../../Shared/constants/api_constants.dart';

class OrderListModalBottomSheet extends StatefulWidget {
  final String? title;
  final Widget? ui;
  final bool? hasTitle;
  final double? height;
  final double? lonData;
  final double? latData;

  const OrderListModalBottomSheet(
      {super.key,
      this.title,
      this.ui,
      this.hasTitle,
      this.height,
      this.lonData,
      this.latData});

  @override
  State<OrderListModalBottomSheet> createState() =>
      _OrderListModalBottomSheetState();
}

class _OrderListModalBottomSheetState extends State<OrderListModalBottomSheet> {
  // kiểm tra thiết bị đang ở hệ điều hành nào
  late final String isActives = Platform.operatingSystem;

  Future<void> backMapIos() async {
    // lấy vị trí mặc định / real time
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation));

    var address = LatLng(position.latitude, position.longitude);

    var lons = address.longitude;
    var lats = address.latitude;

    await launchUrl(
        Uri.parse(
            "${ApiConstants.BASE_GOOGLE_MAP}&origin=$lats,$lons&destination=${widget.latData},${widget.lonData}"),
        mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      isActives == "ios"
          ? Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  height: 35,
                  child: ElevatedButton(
                      onPressed: () => backMapIos(),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              fromHexColor(Constants.COLOR_BUTTON))),
                      child: const Text('Chuyển đến Map',
                          style: TextStyle(fontSize: 14, color: Colors.white))))
            ])
          : const SizedBox(),
      const SizedBox(height: 5),
      Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
          child: Center(
              child: Column(children: [
            widget.hasTitle!
                ? Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(widget.title!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)))
                : const SizedBox(),
            widget.ui!
          ])))
    ]);
  }
}
