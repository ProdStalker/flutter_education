import 'package:education/core/commons/widgets/gradient_background.dart';
import 'package:education/core/res/media_res.dart';
import 'package:education/src/home/presentation/widgets/home_app_bar.dart';
import 'package:education/src/home/refactors/home_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(),
      body: GradientBackground(
        image: MediaRes.homeGradientBackground,
        child: HomeBody(),
      ),
    );
  }
}
