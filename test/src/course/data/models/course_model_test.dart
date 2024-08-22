import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/data/models/course_model.dart';
import 'package:education/src/course/domain/entities/course.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final timestampData = {
    '_seconds': 1677483548,
    '_nanoseconds': 123456000,
  };

  final date =
      DateTime.fromMillisecondsSinceEpoch(timestampData['_seconds']!).add(
    Duration(microseconds: timestampData['_nanoseconds']!),
  );

  final timestamp = Timestamp.fromDate(date);

  final tCourseModel = CourseModel.empty();
  final tMap = jsonDecode(fixture('course.json')) as DataMap;
  tMap['createdAt'] = timestamp;
  tMap['updatedAt'] = timestamp;

  test('should be a subclass of [Course] entity', () {
    expect(tCourseModel, isA<Course>());
  });

  group('empty', () {
    test('should return a [CourseModel] with empty data', () {
      final result = CourseModel.empty();
      expect(result.title, '_empty.title');
    });
  });

  group('fromMap', () {
    test('should return a [CourseModel] with the correct data', () {
      final result = CourseModel.fromMap(tMap);
      expect(result, equals(tCourseModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the proper data', () {
      final result = tCourseModel.toMap()
        ..remove('createdAt')
        ..remove('updatedAt');

      final map = DataMap.from(tMap)
        ..remove('createdAt')
        ..remove('updatedAt');
      expect(result, equals(map));
    });
  });
}
