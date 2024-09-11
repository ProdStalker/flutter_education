import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:education/src/course/features/exams/domain/repos/exam_repo.dart';

class SubmitExam extends UsecaseWithParams<void, UserExam> {
  const SubmitExam(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<void> call(UserExam params) {
    return _repo.submitExam(params);
  }
}
