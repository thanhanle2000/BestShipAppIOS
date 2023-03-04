import 'package:connectivity/connectivity.dart';

import 'bloc/conect_bloc.dart';
import 'bloc/conect_event.dart';

class NetworkHelper {
  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        ConectBloc().add(NetworkNotifyEvent());
      } else {
        ConectBloc().add(NetworkNotifyEvent(isConnected: true));
      }
    });
  }
}
