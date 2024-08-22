import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/domain/entities/course.dart';
import 'package:education/src/course/domain/repos/course_repo.dart';

class GetCourses extends UsecaseWithoutParams<List<Course>> {
  const GetCourses(this._repo);

  final CourseRepo _repo;

  @override
  ResultFuture<List<Course>> call() async {
    return await _repo.getCourses();
  }
}
