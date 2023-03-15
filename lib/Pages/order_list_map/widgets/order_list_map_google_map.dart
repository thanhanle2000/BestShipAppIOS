import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderListGoogleMap extends StatelessWidget {
  final LatLng initialPosition;
  final List<Marker> marker;
  final void Function(GoogleMapController) mapCreatedController;
  const OrderListGoogleMap(
      {super.key,
      required this.initialPosition,
      required this.marker,
      required this.mapCreatedController});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        // ignore: prefer_collection_literals
        circles: Set.from([
          Circle(
              circleId: const CircleId('currentCircle'),
              center: initialPosition,
              radius: 800,
              fillColor: Colors.blue.shade100.withOpacity(0.5),
              strokeColor: Colors.blue.shade100.withOpacity(0.1))
        ]),
        initialCameraPosition:
            CameraPosition(target: initialPosition, zoom: 14),
        markers: marker.toSet(),
        zoomGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        mapToolbarEnabled: true,
        buildingsEnabled:true,
        onMapCreated: mapCreatedController);
  }
}
