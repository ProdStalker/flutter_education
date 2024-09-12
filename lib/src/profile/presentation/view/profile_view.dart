import 'package:education/core/commons/widgets/gradient_background.dart';
import 'package:education/core/enums/notification_enum.dart';
import 'package:education/core/res/media_res.dart';
import 'package:education/core/services/injection_container.dart';
import 'package:education/src/notifications/data/models/notification_model.dart';
import 'package:education/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education/src/profile/presentation/refactory/profile_body.dart';
import 'package:education/src/profile/presentation/refactory/profile_header.dart';
import 'package:education/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaRes.profileGradientBackground,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeader(),
            ProfileBody(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sl<NotificationCubit>().sendNotification(
            NotificationModel.empty().copyWith(
              title: "Test notification",
              body: 'Body',
              category: NotificationCategory.NONE,
            ),
          );
        },
        child: const Icon(IconlyLight.notification),
      ),
    );
  }
}
