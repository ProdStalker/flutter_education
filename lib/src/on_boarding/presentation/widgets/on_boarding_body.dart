import 'package:education/core/extensions/context_extension.dart';
import 'package:education/core/res/colours.dart';
import 'package:education/core/res/fonts.dart';
import 'package:education/src/on_boarding/domain/entities/page_content.dart';
import 'package:flutter/material.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.pageContent, super.key});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          pageContent.image,
          height: context.height * 0.4,
        ),
        SizedBox(
          height: context.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Fonts.aoenik,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 17,
                  ),
                  backgroundColor: Colours.primaryColour,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  // TODO(Get-Started): Implement this functionnality
                  // context.read<OnBoardingCubit>().cacheFirstTimer();
                  // cache user
                  // push then to the appropriate screen
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontFamily: Fonts.aoenik,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
