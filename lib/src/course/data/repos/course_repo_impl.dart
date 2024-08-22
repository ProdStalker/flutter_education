import 'package:dartz/dartz.dart';
import 'package:education/core/errors/exceptions.dart';
import 'package:education/core/errors/failures.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/data/datasources/couse_remote_data_source.dart';
import 'package:education/src/course/domain/entities/course.dart';
import 'package:education/src/course/domain/repos/course_repo.dart';

class CourseRepoImpl implements CourseRepo {
  const CourseRepoImpl(this._remoteDataSource);

  final CourseRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _remoteDataSource.addCourse(course);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final courses = await _remoteDataSource.getCourses();
      return Right(courses);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
