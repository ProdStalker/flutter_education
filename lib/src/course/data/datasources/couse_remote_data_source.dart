import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/core/errors/exceptions.dart';
import 'package:education/core/utils/datasource_utils.dart';
import 'package:education/src/chat/data/models/group_model.dart';
import 'package:education/src/course/data/models/course_model.dart';
import 'package:education/src/course/domain/entities/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class CourseRemoteDataSource {
  const CourseRemoteDataSource();

  Future<void> addCourse(Course course);

  Future<List<CourseModel>> getCourses();
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  const CourseRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _storage = storage,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  @override
  Future<void> addCourse(Course course) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);

      final courseRef = _firestore.collection('courses').doc();
      final groupRef = _firestore.collection('groups').doc();

      var courseModel = (course as CourseModel)
          .copyWith(id: courseRef.id, groupId: groupRef.id);

      if (courseModel.imageIsFile) {
        final imageRef = _storage.ref().child(
              'courses/${courseModel.id}/profile_image/${courseModel.title}-pfp',
            );

        await imageRef.putFile(File(courseModel.image!)).then((value) async {
          final url = await value.ref.getDownloadURL();
          courseModel = courseModel.copyWith(image: url);
        });
      }

      await courseRef.set(courseModel.toMap());

      final group = GroupModel(
        id: groupRef.id,
        name: course.title,
        members: const [],
        courseId: courseRef.id,
        groupImageUrl: courseModel.image,
      );

      return groupRef.set(group.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      return _firestore.collection('courses').get().then(
            (value) => value.docs
                .map((doc) => CourseModel.fromMap(doc.data()))
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }
}
