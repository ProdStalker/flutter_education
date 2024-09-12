import 'package:education/core/utils/core_utils.dart';
import 'package:education/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationWrapper extends StatefulWidget {
  const NotificationWrapper({
    required this.child,
    required this.onNotificationSent,
    this.extraActivity,
    super.key,
  });

  final Widget child;
  final VoidCallback? extraActivity;
  final VoidCallback onNotificationSent;

  @override
  State<NotificationWrapper> createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper> {
  bool showingLoader = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (showingLoader) {
          Navigator.pop(context);
          showingLoader = false;
        }
        showingLoader = false;
        if (state is NotificationSent) {
          widget.extraActivity?.call();
          widget.onNotificationSent();
        } else if (state is SendingNotification) {
          showingLoader = true;
          CoreUtils.showLoadingDialog(context);
        }
      },
      child: widget.child,
    );
  }
}
