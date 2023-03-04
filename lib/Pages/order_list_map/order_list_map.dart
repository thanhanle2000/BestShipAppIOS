import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/order_list_map/widgets/order_list_map_appbar.dart';
import 'package:flutter_app_best_shipp/Pages/order_list_map/widgets/order_list_map_drawer.dart';
import 'package:flutter_app_best_shipp/Pages/order_list_map/widgets/order_list_map_google_map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Shared/widgets/base_widget/snackbar_message.dart';
import 'bloc/map_bloc.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/utils/app_utils.dart';

class OrderListMap extends StatefulWidget {
  const OrderListMap({super.key});

  @override
  State<OrderListMap> createState() => _OrderListMapState();
}

class _OrderListMapState extends State<OrderListMap> {
  late MapBloc _mapBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _mapBloc = context.read<MapBloc>();
    _mapBloc.add(MapBlocStartedEvent(context: context, mapBloc: _mapBloc));
    super.initState();
  }

  Future loadingData() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
                  color: fromHexColor(Constants.COLOR_BUTTON)));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(45.0),
                child: OrderListMapAppbar(title: 'Bản đồ')),
            // ignore: prefer_const_constructors
            endDrawer: OrderListMapDrawer(
              mapBloc: _mapBloc,
              context: context,
            ),
            body: BlocListener<MapBloc, MapBlocState>(listener:
                (context, state) {
              // Bật loading khi tải map
              if (!state.success) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: fromHexColor(Constants.COLOR_BUTTON)));
                    });
              }
              // Tắt loading khi tải dữ liệu bản đồ thành công
              if (state.success) {
                Navigator.of(context).pop();
              }
              // kiểm tra khi không có đơn hàng trong danh sách -> thông báo
              if (state.status == 'fail') {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    snackBar_message('Không có dữ liệu.', "warning"),
                  );
              }
            }, child:
                BlocBuilder<MapBloc, MapBlocState>(builder: (context, state) {
              Future<void> callMaker(GoogleMapController controller) async {}
              var ggMap = OrderListGoogleMap(
                  initialPosition: LatLng(state.latitude, state.longitude),
                  marker: state.lstMarker != null ? state.lstMarker! : [],
                  mapCreatedController: callMaker);
              return ggMap;
            }))));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
