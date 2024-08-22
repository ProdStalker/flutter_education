import 'package:education/src/course/data/models/course_model.dart';
import 'package:education/src/course/domain/entities/course.dart';

abstract class CourseRemoteDataSource {
  const CourseRemoteDataSource();

  Future<void> addCourse(Course course);

  Future<List<CourseModel>> getCourses();
}
