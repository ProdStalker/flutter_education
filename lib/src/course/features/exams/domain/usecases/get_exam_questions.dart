import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/features/exams/domain/entities/exam.dart';
import 'package:education/src/course/features/exams/domain/entities/exam_question.dart';
import 'package:education/src/course/features/exams/domain/repos/exam_repo.dart';

class GetExamQuestions
    extends FutureUsecaseWithParams<List<ExamQuestion>, Exam> {
  const GetExamQuestions(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<List<ExamQuestion>> call(Exam params) =>
      _repo.getExamQuestions(params);
}
