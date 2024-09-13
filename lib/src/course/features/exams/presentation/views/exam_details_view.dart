import 'package:education/src/course/features/exams/domain/entities/exam.dart';
import 'package:flutter/material.dart';

class ExamDetailsView extends StatefulWidget {
  const ExamDetailsView(this.exam, {super.key});

  static const String routeName = '/exam-details';

  final Exam exam;

  @override
  State<ExamDetailsView> createState() => _ExamDetailsViewState();
}

class _ExamDetailsViewState extends State<ExamDetailsView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
