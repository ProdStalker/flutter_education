import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/features/exams/domain/entities/exam.dart';
import 'package:education/src/course/features/exams/domain/repos/exam_repo.dart';

class GetExams extends UsecaseWithParams<List<Exam>, String> {
  const GetExams(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<List<Exam>> call(String params) {
    return _repo.getExams(params);
  }
}
