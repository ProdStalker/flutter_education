import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:education/src/course/features/exams/domain/repos/exam_repo.dart';

class GetUserCourseExams extends UsecaseWithParams<List<UserExam>, String> {
  const GetUserCourseExams(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<List<UserExam>> call(String params) =>
      _repo.getUserCourseExams(params);
}
