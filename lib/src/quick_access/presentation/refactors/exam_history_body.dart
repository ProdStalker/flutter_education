import 'package:education/core/commons/views/loading_view.dart';
import 'package:education/core/commons/widgets/not_found_text.dart';
import 'package:education/core/utils/core_utils.dart';
import 'package:education/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:education/src/quick_access/presentation/widgets/exam_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamHistoryBody extends StatefulWidget {
  const ExamHistoryBody({super.key});

  @override
  State<ExamHistoryBody> createState() => _ExamHistoryBodyState();
}

class _ExamHistoryBodyState extends State<ExamHistoryBody> {
  void getHistory() {
    context.read<ExamCubit>().getUserExams();
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamCubit, ExamState>(
      listener: (_, state) {
        if (state is ExamError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is GettingUserExams) {
          return const LoadingView();
        } else if ((state is UserExamsLoaded && state.exams.isEmpty) ||
            state is ExamError) {
          return const NotFoundText(
            'No exams found',
          );
        } else if (state is UserExamsLoaded) {
          final userExams = state.exams
            ..sort((a, b) => b.dateSubmitted.compareTo(a.dateSubmitted));

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: userExams.length,
            itemBuilder: (context, index) {
              final userExam = userExams[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExamHistoryTile(userExam),
                  if (index != userExams.length - 1)
                    const SizedBox(
                      height: 20,
                    ),
                ],
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
