import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_best_shipp/Pages/payment_shipper/bloc/payment_shipper_bloc.dart';

abstract class PaymentShipperEvent extends Equatable {
  const PaymentShipperEvent();

  @override
  List<Object> get props => [];
}

class PaymentShipperStartedEvent extends PaymentShipperEvent {}

class PaymentShipperConfirmEvent extends PaymentShipperEvent {
  final int PaymentId;
  final PaymentShipperBloc paymentBloc;
  final BuildContext context;

  const PaymentShipperConfirmEvent(
      {required this.PaymentId,
      required this.paymentBloc,
      required this.context});

  @override
  List<Object> get props => [PaymentId];

  @override
  String toString() {
    return 'PaymentShipperConfirmEvent { PaymentId: $PaymentId }';
  }
}
