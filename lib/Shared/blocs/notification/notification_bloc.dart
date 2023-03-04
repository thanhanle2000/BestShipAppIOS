import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  // final PushNotificationRepository pushNotificationRepository;

  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) async {
      if (event is FetchNotificationCountsEvent) {
        //  _mapFetchNotificationCountsToState
      } else if (event is ResetNotificationCountsEvent) {
        emit(NotificationCountLoading());
        final currentState = state;
        if (currentState is NotificationCountsLoaded) {
          try {
            emit(const NotificationCountsLoaded(notificationCounts: 0));
          } catch (_) {
            emit(NotificationError());
          }
        }
      } else if (event is FetchNotificationEvent) {
        // yield* _mapFetchNotificationsToState(event);
      }
    });
  }
}
