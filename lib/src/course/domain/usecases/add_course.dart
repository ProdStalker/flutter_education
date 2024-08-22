import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/domain/entities/course.dart';
import 'package:education/src/course/domain/repos/course_repo.dart';

class AddCourse extends UsecaseWithParams<void, Course> {
  const AddCourse(this._repo);

  final CourseRepo _repo;

  @override
  ResultFuture<void> call(Course params) async {
    return _repo.addCourse(params);
  }
}
