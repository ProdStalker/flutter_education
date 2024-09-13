import 'package:education/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:education/src/quick_access/presentation/widgets/exam_history_answer_tile.dart';
import 'package:education/src/quick_access/presentation/widgets/exam_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamHistoryDetailsScreen extends StatelessWidget {
  const ExamHistoryDetailsScreen(this.userExam, {super.key});

  static const String routeName = '/exam-history-details';

  final UserExam userExam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${userExam.examTitle} Details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExamHistoryTile(
                userExam,
                navigateToDetails: false,
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  text: 'Date Submitted: ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: DateFormat.yMMMMd().format(userExam.dateSubmitted),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, __) => const Divider(
                    thickness: 1,
                    color: Color(0xFFE6E8EC),
                  ),
                  itemCount: userExam.answers.length,
                  itemBuilder: (_, index) {
                    final answer = userExam.answers[index];
                    return ExamHistoryAnswerTile(
                      answer,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
