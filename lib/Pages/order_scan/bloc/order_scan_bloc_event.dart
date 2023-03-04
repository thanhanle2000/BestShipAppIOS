import 'package:equatable/equatable.dart';

abstract class OrderScanEvent extends Equatable {
  const OrderScanEvent();

  @override
  List<Object> get props => [];
}

class OrderScanStartedEvent extends OrderScanEvent {}

// sự kiện lấy total scan
class OrderScanBlocTotalScanEvent extends OrderScanEvent {
  final int shopId;
  final String date;

  const OrderScanBlocTotalScanEvent({required this.shopId, required this.date});

  @override
  List<Object> get props => [
        shopId,
      ];

  @override
  String toString() {
    return 'OrderScanBlocTotalScanEvent { shopId: $shopId }';
  }
}

// sự kiện lấy danh sách shop
class OrderScanListShopEvent extends OrderScanEvent {
  final String key;

  const OrderScanListShopEvent({required this.key});

  @override
  List<Object> get props => [key];

  @override
  String toString() {
    return 'OrderScanListShopEvent { key: $key }';
  }
}

// sự kiện lấy danh sách user
class OrderScanListUserEvent extends OrderScanEvent {
  final String key;

  const OrderScanListUserEvent({required this.key});

  @override
  List<Object> get props => [key];

  @override
  String toString() {
    return 'OrderScanListUserEvent { key: $key }';
  }
}

// sự kiện scan qua textfield
class OrderScanTextFieldEvent extends OrderScanEvent {
  final String date;
  final int shopId;
  final String code;
  final String pickuper;

  const OrderScanTextFieldEvent(
      {required this.date,
      required this.shopId,
      required this.code,
      required this.pickuper});

  @override
  List<Object> get props => [date, shopId, code, pickuper];

  @override
  String toString() {
    return 'OrderScanTextFieldEvent { date: $date,shopId: $shopId,code:$code,pickuper:$pickuper  }';
  }
}

// sự kiện scan qua mã qr bằng camera đơn
class OrderScanQREvent extends OrderScanEvent {
  final String date;
  final int shopId;
  final String code;
  final String pickuper;

  const OrderScanQREvent(
      {required this.date,
      required this.shopId,
      required this.code,
      required this.pickuper});

  @override
  List<Object> get props => [date, shopId, code, pickuper];

  @override
  String toString() {
    return 'OrderScanQREvent { date: $date,shopId: $shopId,code:$code,pickuper:$pickuper  }';
  }
}

// sự kiện scan qua mã qr bằng camera liên tục
class OrderScanContinuousQREvent extends OrderScanEvent {
  final String date;
  final int shopId;
  final String code;
  final String pickuper;

  const OrderScanContinuousQREvent(
      {required this.date,
      required this.shopId,
      required this.code,
      required this.pickuper});

  @override
  List<Object> get props => [date, shopId, code, pickuper];

  @override
  String toString() {
    return 'OrderScanContinuousQREvent {  date: $date,shopId: $shopId,code:$code,pickuper:$pickuper  }';
  }
}

// sự kiện scan qua mã barcode bằng camera liên tục
class OrderScanContinuousBarcodeEvent extends OrderScanEvent {
  final String date;
  final int shopId;
  final String code;
  final String pickuper;

  const OrderScanContinuousBarcodeEvent(
      {required this.date,
      required this.shopId,
      required this.code,
      required this.pickuper});

  @override
  List<Object> get props => [date, shopId, code, pickuper];

  @override
  String toString() {
    return 'OrderScanContinuousBarcodeEvent {  date: $date,shopId: $shopId,code:$code,pickuper:$pickuper  }';
  }
}

class OrderScanModelShared extends OrderScanEvent {
  final String date;
  final int shopId;
  final String userName;
  const OrderScanModelShared(
      {required this.date, required this.shopId, required this.userName});

  @override
  List<Object> get props => [date, shopId, userName];

  @override
  String toString() {
    return 'OrderScanModelShared { date: $date ,shopId: $shopId,userName: $userName }';
  }
}
