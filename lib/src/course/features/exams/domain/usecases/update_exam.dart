import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/features/exams/domain/entities/exam.dart';
import 'package:education/src/course/features/exams/domain/repos/exam_repo.dart';

class UpdateExam extends FutureUsecaseWithParams<void, Exam> {
  const UpdateExam(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<void> call(Exam params) => _repo.updateExam(params);
}
