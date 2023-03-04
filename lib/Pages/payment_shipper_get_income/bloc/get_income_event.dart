import 'package:equatable/equatable.dart';

abstract class GetIncomeEvent extends Equatable {
  const GetIncomeEvent();

  @override
  List<Object> get props => [];
}

class GetIncomeStartedEvent extends GetIncomeEvent {}

// sự kiện lấy danh sách user
class GetIncomeListUserEvent extends GetIncomeEvent {
  final String key;

  const GetIncomeListUserEvent({required this.key});

  @override
  List<Object> get props => [key];

  @override
  String toString() {
    return 'GetIncomeListUserEvent { key: $key }';
  }
}

class GetIncomeReloadEvent extends GetIncomeEvent {
  final String key;

  const GetIncomeReloadEvent({required this.key});

  @override
  List<Object> get props => [key];

  @override
  String toString() {
    return 'GetIncomeReloadEvent { key: $key }';
  }
}
