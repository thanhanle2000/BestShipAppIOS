// ignore_for_file: unnecessary_null_comparison

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/bloc/order_scan_bloc_event.dart';
import 'package:flutter_app_best_shipp/Pages/order_scan/bloc/order_scan_bloc_state.dart';
import 'package:flutter_app_best_shipp/Shared/models/auth/list_user/list_user_models.dart';
import 'package:flutter_app_best_shipp/Shared/models/order_scan/order_scan_list_shop.dart';
import 'package:flutter_app_best_shipp/presentation/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Shared/models/order_scan/order_scan_status.dart';
import '../../../Shared/models/order_scan/order_scan_total.dart';
import '../../../presentation/repositories/order/order_respository.dart';

class OrderScanBloc extends Bloc<OrderScanEvent, OrderScanState> {
  final OrderRespository _orderRespository;
  final UserRepository _userRepository;
  OrderScanBloc(
      {required OrderRespository orderRespository,
      required UserRepository userRepository})
      : assert(orderRespository != null, userRepository != null),
        _orderRespository = orderRespository,
        _userRepository = userRepository,
        super(OrderScanState.empty()) {
    on<OrderScanEvent>((event, emit) async {
      final player = AudioPlayer();
      if (event is OrderScanStartedEvent) {
        emit(OrderScanState.empty());
      } else if (event is OrderScanBlocTotalScanEvent) {
        emit(OrderScanState.empty());
        // lấy dữ liệu cho total scan
        OrderScanModels orderScanModels =
            await _orderRespository.getDataTotalScan(event.date, event.shopId);
        DataTotalScan data = orderScanModels.data!;
        emit(OrderScanState.start(true, OrderScanStatus(),
            'OrderScanBlocTotalScan', '', event.shopId, '', data, [], []));
      } else if (event is OrderScanListShopEvent) {
        // lấy dữ liệu cho danh sách shop
        OrderScanListShopModels orderListShop = await _orderRespository
            .getDataListShop(event.key.isNotEmpty ? event.key : '');
        List<DataListShop> dataListShop = orderListShop.data!;
        emit(OrderScanState.start(true, OrderScanStatus(), 'OrderScanListShop',
            '', 0, '', DataTotalScan(), dataListShop, []));
      } else if (event is OrderScanListUserEvent) {
        // lấy dữ liệu cho danh sách user
        ListUserModels listUserModels = await _userRepository
            .listDataUser(event.key.isNotEmpty ? event.key : '');
        List<DataUser> dataUser = listUserModels.data!;
        emit(OrderScanState.start(true, OrderScanStatus(), 'OrderScanListUser',
            '', 0, '', DataTotalScan(), [], dataUser));
      } else if (event is OrderScanTextFieldEvent) {
        // hàm xử lí order scan qua textfield
        OrderScanStatus orderScanStatus = await _orderRespository.getDataScan(
            event.shopId, event.code, event.pickuper);
        // lấy dữ liệu cho total scan
        OrderScanModels orderScanModels =
            await _orderRespository.getDataTotalScan(event.date, event.shopId);
        player.play(AssetSource(
            orderScanStatus.success! ? 'mp3/ting.mp3' : 'mp3/buzz-error.mp3'));
        DataTotalScan data = orderScanModels.data!;
        // gọi lại hàm cập nhật total sao khi quét thành công
        emit(OrderScanState.start(true, orderScanStatus, 'OrderScan_TextFields',
            '', event.shopId, '', data, [], []));
      } else if (event is OrderScanQREvent) {
        // hàm xử lí order scan qr & barcode qua camera đơn
        OrderScanStatus orderScanStatus = await _orderRespository.getDataScan(
            event.shopId, event.code.trim(), event.pickuper);
        // lấy dữ liệu cho total scan
        OrderScanModels orderScanModels =
            await _orderRespository.getDataTotalScan(event.date, event.shopId);
        player.play(AssetSource(orderScanStatus.success == true
            ? 'mp3/ting.mp3'
            : 'mp3/buzz-error.mp3'));
        DataTotalScan data = orderScanModels.data!;
        // gọi lại hàm cập nhật total sao khi quét thành công
        emit(OrderScanState.start(true, orderScanStatus, 'OrderScan_QR', '',
            event.shopId, '', data, [], []));
      } else if (event is OrderScanContinuousQREvent) {
        // hàm xử lí order scan qr qua camera liện tục
        OrderScanStatus orderScanStatus = await _orderRespository.getDataScan(
            event.shopId, event.code.trim(), event.pickuper);
        // lấy dữ liệu cho total scan
        OrderScanModels orderScanModels =
            await _orderRespository.getDataTotalScan(event.date, event.shopId);
        player.play(AssetSource(
            orderScanStatus.success! ? 'mp3/ting.mp3' : 'mp3/buzz-error.mp3'));
        DataTotalScan data = orderScanModels.data!;
        // gọi lại hàm cập nhật total sao khi quét thành công
        emit(OrderScanState.start(true, orderScanStatus,
            'OrderScan_Continuous_QR', '', event.shopId, '', data, [], []));
      } else if (event is OrderScanModelShared) {
        emit(OrderScanState.start(
            true,
            OrderScanStatus(),
            'OrderScan_Continuous_QR',
            event.date,
            event.shopId,
            event.userName,
            DataTotalScan(), [], []));
      }
    });
  }
}
