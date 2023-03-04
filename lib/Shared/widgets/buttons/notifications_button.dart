import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/notification/notification_bloc.dart';

class NotificationButton extends StatefulWidget {
  final Color bubbleColor;
  final Icon icon;

  const NotificationButton(
      {super.key, required this.bubbleColor, required this.icon});

  @override
  State<StatefulWidget> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  void initState() {
    context.read<NotificationBloc>().add(FetchNotificationCountsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.icon,
        BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationCountsLoaded &&
                state.notificationCounts > 0) {
              return Positioned(
                left: 11.0,
                top: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: widget.bubbleColor ?? Colors.white.withOpacity(.4),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      '${state.notificationCounts}',
                      style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }
            return Container(height: 0, width: 0);
          },
        )
      ],
    );
  }
}
