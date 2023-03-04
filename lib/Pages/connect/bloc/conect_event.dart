abstract class ConectEvent {}

class NetworkObserveEvent extends ConectEvent {}

class NetworkNotifyEvent extends ConectEvent {
  final bool isConnected;

  NetworkNotifyEvent({this.isConnected = false});
}
