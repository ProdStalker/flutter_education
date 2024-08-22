import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/domain/entities/course.dart';

abstract class CourseRepo {
  const CourseRepo();

  ResultFuture<List<Course>> getCourses();

  ResultFuture<void> addCourse(Course course);
}
