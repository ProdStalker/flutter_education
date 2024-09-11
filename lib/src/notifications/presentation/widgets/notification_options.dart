import 'package:education/core/commons/app/providers/notifications_notifier.dart';
import 'package:education/core/commons/widgets/popup_item.dart';
import 'package:education/core/res/colours.dart';
import 'package:education/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationOptions extends StatelessWidget {
  const NotificationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationNotifier>(
      builder: (_, notifier, __) {
        return PopupMenuButton(
          offset: const Offset(0, 50),
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<void>(
              onTap: notifier.toggleNotifications,
              child: PopupItem(
                title: notifier.muteNotifications
                    ? 'Unmute Notifications'
                    : 'Mute Notifications',
                icon: Icon(
                  notifier.muteNotifications
                      ? Icons.notifications_off_outlined
                      : Icons.notifications_outlined,
                ),
              ),
            ),
            PopupMenuItem<void>(
              onTap: () {
                context.read<NotificationCubit>().clearAll();
              },
              child: const PopupItem(
                title: 'Clear All',
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
