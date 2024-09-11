import 'package:education/core/commons/app/providers/course_of_the_day_notifier.dart';
import 'package:education/core/commons/views/loading_view.dart';
import 'package:education/core/commons/widgets/not_found_text.dart';
import 'package:education/core/utils/core_utils.dart';
import 'package:education/src/course/presentation/cubit/course_cubit.dart';
import 'package:education/src/home/refactors/home_header.dart';
import 'package:education/src/home/refactors/home_subjects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    getCourses();
  }

  void getCourses() {
    context.read<CourseCubit>().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      builder: (context, state) {
        if (state is! CoursesLoaded && state is LoadingCourses) {
          return const LoadingView();
        } else if (state is CoursesLoaded && state.courses.isEmpty ||
            state is CourseError) {
          return const NotFoundText(
            'No courses found\nPlease contact admin or if you are admin, '
            'add courses',
          );
        } else if (state is CoursesLoaded) {
          final courses = state.courses
            ..sort(
              (a, b) => b.updatedAt.compareTo(a.updatedAt),
            );

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const HomeHeader(),
              const SizedBox(
                height: 20,
              ),
              HomeSubjects(courses: courses),
            ],
          );
        }

        return const SizedBox.shrink();
      },
      listener: (_, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is CoursesLoaded && state.courses.isNotEmpty) {
          final courses = state.courses..shuffle();
          final courseOfTheDay = courses.first;
          context
              .read<CourseOfTheDayNotifier>()
              .setCourseOfTheDay(courseOfTheDay);
        }
      },
    );
  }
}
