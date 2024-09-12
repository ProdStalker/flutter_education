import 'package:audioplayers/audioplayers.dart';
import 'package:badges/badges.dart';
import 'package:education/core/commons/app/providers/notifications_notifier.dart';
import 'package:education/core/extensions/context_extension.dart';
import 'package:education/core/services/injection_container.dart';
import 'package:education/core/utils/core_utils.dart';
import 'package:education/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education/src/notifications/presentation/views/notifications_view.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class NotificationBell extends StatefulWidget {
  const NotificationBell({super.key});

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  final newNotificationListenable = ValueNotifier<bool>(false);
  int? notificationCount;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotifications();
    newNotificationListenable.addListener(() {
      if (newNotificationListenable.value) {
        if (context.read<NotificationNotifier>().muteNotifications) {
          player.play(AssetSource('sounds/notification.mp3'));
        }
        newNotificationListenable.value = false;
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (_, state) {
        if (state is NotificationsLoaded) {
          if (notificationCount != null) {
            if (notificationCount! < state.notifications.length) {
              newNotificationListenable.value = true;
            }
          }

          notificationCount = state.notifications.length;
        } else if (state is NotificationError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is NotificationsLoaded) {
          final unseenNotificationsLength = state.notifications
              .where((notification) => !notification.seen)
              .length;
          final showBadge = unseenNotificationsLength > 0;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                context.push(
                  BlocProvider.value(
                    value: sl<NotificationCubit>(),
                    child: const NotificationsView(),
                  ),
                );
              },
              child: Badge(
                showBadge: showBadge,
                position: BadgePosition.topEnd(end: 1),
                badgeContent: Text(
                  unseenNotificationsLength.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
                child: const Icon(IconlyLight.notification),
              ),
            ),
          );
        }

        return const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(IconlyLight.notification),
        );
      },
    );
  }
}
