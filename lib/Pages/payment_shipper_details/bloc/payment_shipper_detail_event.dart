import 'package:equatable/equatable.dart';

abstract class PaymentShipperDetailsEvent extends Equatable {
  const PaymentShipperDetailsEvent();

  @override
  List<Object> get props => [];
}

class PaymentShipperDetailsStartedEvent extends PaymentShipperDetailsEvent {}
