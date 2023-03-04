part of '../../../Pages/order_list_map/bloc/map_bloc.dart';

abstract class MapBlocEvent extends Equatable {
  const MapBlocEvent();

  @override
  List<Object> get props => [];
}

class MapBlocStartedEvent extends MapBlocEvent {
  final BuildContext? context;
  final MapBloc mapBloc;

  const MapBlocStartedEvent({required this.context, required this.mapBloc});
}

class MapBlocMyLocationEvent extends MapBlocEvent {
  final double latitude;
  final double longitude;
  final List<OrderModels> data;
  const MapBlocMyLocationEvent(
      {required this.latitude, required this.longitude, required this.data});

  @override
  List<Object> get props => [latitude, longitude];
  @override
  String toString() {
    return 'MapBlocMyLocationEvent { latitude: $latitude, longitude: $longitude, data $data }';
  }
}

class MapBlocEventSuccessEvent extends MapBlocEvent {
  final int shopId;
  final String code;
  final String shipper;
  final StatusData statusModels;
  final BuildContext context;
  final MapBloc mapBloc;

  const MapBlocEventSuccessEvent({
    required this.shopId,
    required this.code,
    required this.shipper,
    required this.statusModels,
    required this.context,
    required this.mapBloc,
  });

  @override
  List<Object> get props => [shopId, code, shipper, statusModels, context];

  @override
  String toString() {
    return 'MapBlocEventSuccessEvent { shopId: $shopId, code: $code, shipper: $shipper, statusModels : $statusModels }';
  }
}

class MapBlocEventCancelEvent extends MapBlocEvent {
  final int shopId;
  final String code;
  final String shipper;
  final int CancelId;
  final String cancelReason;
  final StatusData statusModels;
  final BuildContext context;
  final MapBloc mapBloc;

  const MapBlocEventCancelEvent(
      {required this.shopId,
      required this.code,
      required this.shipper,
      required this.CancelId,
      required this.cancelReason,
      required this.statusModels,
      required this.context,
      required this.mapBloc});

  @override
  List<Object> get props => [
        shopId,
        code,
        shipper,
        CancelId,
        cancelReason,
        statusModels,
        context,
        mapBloc
      ];

  @override
  String toString() {
    return 'MapBlocEventCancelEvent { shopId: $shopId, code: $code, shipper: $shipper, CancelId: $CancelId,cancelReason : $cancelReason ,statusModels : $statusModels }';
  }
}

class MapBlocEventChangeActionEvent extends MapBlocEvent {
  final int shopId;
  final String code;
  final int action_item_id;
  final int action_call_time;
  final String shipper;
  final int action_id;
  final String action_text;
  final StatusData statusModels;
  final BuildContext context;
  final MapBloc mapBloc;

  const MapBlocEventChangeActionEvent(
      {required this.shopId,
      required this.code,
      required this.action_item_id,
      required this.action_call_time,
      required this.shipper,
      required this.action_id,
      required this.action_text,
      required this.statusModels,
      required this.context,
      required this.mapBloc});

  @override
  List<Object> get props => [
        shopId,
        code,
        action_item_id,
        action_call_time,
        shipper,
        action_id,
        action_text,
        statusModels,
        context,
        mapBloc
      ];

  @override
  String toString() {
    return 'MapBlocEventChangeActionEvent { shopId: $shopId, code: $code, action_item_id: $action_item_id, action_call_time: $action_call_time,shipper : $shipper,action_id: $action_id ,statusModels : $statusModels }';
  }
}
