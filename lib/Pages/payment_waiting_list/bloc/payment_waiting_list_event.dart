import 'package:equatable/equatable.dart';

abstract class PaymentWaitingListEvent extends Equatable {
  const PaymentWaitingListEvent();

  @override
  List<Object> get props => [];
}

class PaymentWaitingListStartedEvent extends PaymentWaitingListEvent {}
