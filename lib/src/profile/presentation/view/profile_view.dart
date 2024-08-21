import 'package:education/core/commons/widgets/gradient_background.dart';
import 'package:education/core/res/media_res.dart';
import 'package:education/src/profile/presentation/refactory/profile_body.dart';
import 'package:education/src/profile/presentation/refactory/profile_header.dart';
import 'package:education/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
