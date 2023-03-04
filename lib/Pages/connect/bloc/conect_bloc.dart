import 'package:flutter_bloc/flutter_bloc.dart';

import '../conect_helper.dart';
import 'conect_event.dart';
import 'conect_state.dart';

class ConectBloc extends Bloc<ConectEvent, ConectState> {
  ConectBloc._() : super(NetworkInitial()) {
    on<NetworkObserveEvent>(_observe);
    on<NetworkNotifyEvent>(_notifyStatus);
  }

  static final ConectBloc _instance = ConectBloc._();

  factory ConectBloc() => _instance;

  void _observe(event, emit) {
    NetworkHelper.observeNetwork();
  }

  void _notifyStatus(NetworkNotifyEvent event, emit) {
    event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
  }
}
