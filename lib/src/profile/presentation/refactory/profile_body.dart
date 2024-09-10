import 'package:education/core/commons/app/providers/user_provider.dart';
import 'package:education/core/res/colours.dart';
import 'package:education/core/res/media_res.dart';
import 'package:education/src/profile/presentation/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        return user == null
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: UserInfoCard(
                          infoThemeColour: Colours.physicsTileColour,
                          infoIcon: const Icon(
                            IconlyLight.document,
                            size: 24,
                            color: Color(0xFF767DFF),
                          ),
                          infoTitle: 'Courses',
                          infoValue: user.enrolledCourseIds.length.toString(),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: UserInfoCard(
                          infoThemeColour: Colours.languageTileColour,
                          infoIcon: Image.asset(
                            MediaRes.scoreboard,
                            height: 24,
                            width: 24,
                          ),
                          infoTitle: 'Score',
                          infoValue: user.points.toString(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: UserInfoCard(
                          infoThemeColour: Colours.biologyTileColour,
                          infoIcon: const Icon(
                            IconlyLight.user,
                            color: Color(0xFF56AEFF),
                            size: 24,
                          ),
                          infoTitle: 'Followers',
                          infoValue: user.followers.length.toString(),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: UserInfoCard(
                          infoThemeColour: Colours.chemistryTileColour,
                          infoIcon: const Icon(
                            IconlyLight.user,
                            color: Color(0xFFFF84AA),
                            size: 24,
                          ),
                          infoTitle: 'Following',
                          infoValue: user.following.length.toString(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
      },
    );
  }
}
