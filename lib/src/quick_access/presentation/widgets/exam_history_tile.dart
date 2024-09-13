import 'package:education/core/res/colours.dart';
import 'package:education/core/res/media_res.dart';
import 'package:education/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:education/src/quick_access/presentation/views/exam_history_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ExamHistoryTile extends StatelessWidget {
  const ExamHistoryTile(
    this.userExam, {
    super.key,
    this.navigateToDetails = true,
  });

  final UserExam userExam;
  final bool navigateToDetails;

  @override
  Widget build(BuildContext context) {
    final answeredQuestionsPercentage =
        userExam.answers.length / userExam.totalQuestions;
    final percentageColor = answeredQuestionsPercentage < 0.5
        ? Colours.redColour
        : Colours.greenColour;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: navigateToDetails
          ? () => Navigator.of(context).pushNamed(
              ExamHistoryDetailsScreen.routeName,
              arguments: userExam,)
          : null,
      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: Colours.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: userExam.examImageUrl == null
                ? Image.asset(MediaRes.test)
                : Image.network(userExam.examImageUrl!),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userExam.examTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'You have completed',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    text:
                        '${userExam.answers.length}/${userExam.totalQuestions}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: percentageColor,
                    ),
                    children: const [
                      TextSpan(
                        text: 'questions',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          CircularStepProgressIndicator(
            totalSteps: userExam.totalQuestions,
            currentStep: userExam.answers.length,
            selectedColor: percentageColor,
            padding: 0,
            width: 60,
            height: 60,
            child: Center(
              child: Text(
                '${(answeredQuestionsPercentage * 100).toInt()}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: percentageColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
