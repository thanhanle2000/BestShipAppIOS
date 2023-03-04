part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class InitPushNotificationEvent extends NotificationEvent {
  final BuildContext context;

  InitPushNotificationEvent(this.context);

  @override
  List<Object> get props => [context];
}

class FetchNotificationCountsEvent extends NotificationEvent {
  @override
  List<Object> get props => [];
}

class ResetNotificationCountsEvent extends NotificationEvent {
  @override
  List<Object> get props => [];
}

class FetchNotificationEvent extends NotificationEvent {
  @override
  List<Object> get props => [];
}
