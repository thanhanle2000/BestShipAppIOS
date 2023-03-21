import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../Shared/models/order_list/order_list_models.dart';
import '../../../Shared/models/status/status_models.dart';
import '../../../presentation/repositories/order/order_respository.dart';
import '../../../presentation/repositories/order/order_map_repository.dart';
part 'map_bloc_event.dart';
part 'map_bloc_state.dart';

class MapBloc extends Bloc<MapBlocEvent, MapBlocState> {
  final MapRepository _mapRepository;
  final OrderRespository _orderRespository;

  MapBloc(
      {required MapRepository mapRepository,
      required OrderRespository orderRespository})
      : _mapRepository = mapRepository,
        _orderRespository = orderRespository,
        super(MapBlocState.empty()) {
    on<MapBlocEvent>((event, emit) async {
      // khai báo dữ liệu đầu vào
      OrderListModels orderlistData = OrderListModels();
      StatusModels statusModels = StatusModels();
      if (event is MapBlocStartedEvent) {
        emit(MapBlocState.empty());
        try {
          // lấy location
          LatLng initialPosition = await _mapRepository.getUserLocation();

          // lấy data
          orderlistData = await orderRespository.getDataForMap();

          var lstMaker = await _mapRepository.getDataMaker(
              orderlistData.data!, StatusData(), event.context!, event.mapBloc);

          emit(MapBlocState.start(
              true,
              'MapBlocStarted',
              initialPosition.latitude,
              // ignore: null_check_always_fails
              initialPosition.longitude,
              orderlistData.data!,
              StatusData(),
              lstMaker));
        } catch (_) {
          emit(MapBlocState.fail('Hôm nay đã hết đơn'));
        }
      } else if (event is MapBlocEventSuccessEvent) {
        emit(MapBlocState.empty());
        // chuyển trạng thái thành công từ trạng thái đang giao hàng -> trạng thái đơn hàng thành công
        LatLng initialPosition = await _mapRepository.getUserLocation();

        // lấy data cho trạng thái đơn hàng sau khi thực hiện chuyển trạng thái
        statusModels = await _orderRespository.getDataSuccess(
            event.shopId, event.code, event.shipper);

        // lấy data cho danh sách đơn hàng
        orderlistData = await orderRespository.getDataForMap();

        // lấy data cho danh sách marker
        // ignore: use_build_context_synchronously
        var lstMaker = await _mapRepository.getDataMaker(
            orderlistData.data!, StatusData(), event.context, event.mapBloc);

        emit(MapBlocState.start(
            true,
            'MapBlocEventSuccess',
            initialPosition.latitude,
            // ignore: null_check_always_fails
            initialPosition.longitude,
            orderlistData.data!,
            StatusData(),
            lstMaker));
      } else if (event is MapBlocEventCancelEvent) {
        // chuyển trạng thái thành công từ trạng thái đang giao hàng -> trạng thái đơn hàng hủy
        emit(MapBlocState.empty());
        LatLng initialPosition = await _mapRepository.getUserLocation();
        // lấy data cho danh sách đơn hàng
        statusModels = await _orderRespository.getDataCancel(event.shopId,
            event.code, event.shipper, event.CancelId, event.cancelReason);
        orderlistData = await orderRespository.getDataForMap();

        // lấy data cho danh sách marker
        // ignore: use_build_context_synchronously
        var lstMaker = await _mapRepository.getDataMaker(
            orderlistData.data!, StatusData(), event.context, event.mapBloc);

        emit(MapBlocState.start(
            true,
            'MapBlocEventCancel',
            initialPosition.latitude,
            // ignore: null_check_always_fails
            initialPosition.longitude,
            orderlistData.data!,
            StatusData(),
            lstMaker));
      } else if (event is MapBlocEventChangeActionEvent) {
        // chuyển trạng thái thành công từ trạng thái đang giao hàng -> trạng thái đơn hàng (k nghe máy, thuê bao, hẹn giao)
        emit(MapBlocState.empty());
        LatLng initialPosition = await _mapRepository.getUserLocation();

        // lấy data cho trạng thái đơn hàng sau khi thực hiện chuyển trạng thái
        statusModels = await _orderRespository.getDataAction(
            event.shopId,
            event.code,
            event.action_item_id,
            event.action_call_time,
            event.shipper,
            event.action_id,
            event.action_text);

        // lấy data cho danh sách đơn hàng
        orderlistData = await orderRespository.getDataForMap();

        // lấy data cho danh sách marker
        // ignore: use_build_context_synchronously
        var lstMaker = await _mapRepository.getDataMaker(
            orderlistData.data!, StatusData(), event.context, event.mapBloc);

        emit(MapBlocState.start(
            true,
            'MapBlocEventChangeAction',
            initialPosition.latitude,
            // ignore: null_check_always_fails
            initialPosition.longitude,
            orderlistData.data!,
            StatusData(),
            lstMaker));
      }
    });
  }
}
