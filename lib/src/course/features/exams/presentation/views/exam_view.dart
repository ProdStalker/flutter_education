import 'package:education/core/utils/core_utils.dart';
import 'package:education/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:education/src/course/features/exams/presentation/app/providers/exam_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ExamView extends StatefulWidget {
  const ExamView({super.key});

  static const routeName = '/exam';

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  bool showingLoader = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamController>(builder: (_, controller, __) {
      return BlocConsumer(
        listener: (_, state) {
          if (showingLoader) {
            Navigator.pop(context);
            showingLoader = false;
          }
          if (state is ExamError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SubmittingExam) {
            CoreUtils.showLoadingDialog(context);
            showingLoader = true;
          } else if (state is ExamSubmitted) {
            CoreUtils.showSnackBar(context, 'Exam submitted');
            Navigator.pop(context);
          }
        },
        builder: (context, state) => WillPopScope(
          onWillPop: () async {
            if (state is SubmittingExam) {
              return false;
            }
            if (controller.isTimeUp) {
              return true;
            }

            final result = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                  title: Text('Exit Exam'),
                  content: Text('Are you sure you want to Exit the exam?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text(
                        'Exit exam',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );
            return result ?? false;
          },
          child: const Placeholder(),
        ),
      );
    });
  }
}
