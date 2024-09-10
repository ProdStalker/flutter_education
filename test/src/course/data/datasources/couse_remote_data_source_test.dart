import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/auth/data/models/user_model.dart';
import 'package:education/src/course/data/datasources/couse_remote_data_source.dart';
import 'package:education/src/course/data/models/course_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {
  String _uid = 'Test uid';

  @override
  String get uid => _uid;

  set uid(String value) {
    if (_uid != value) _uid = value;
  }
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;
  User? _user;

  @override
  User? get user => _user;

  set user(User? value) {
    if (_user != value) _user = value;
  }
}

class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  late CourseRemoteDataSource remoteDataSource;
  late FirebaseFirestore firestore;
  late FirebaseAuth auth;
  late MockFirebaseStorage storage;
  late UserCredential userCredential;
  late DocumentReference<DataMap> documentReference;
  late MockUser mockUser;

  const tUser = LocalUserModel.empty();

  setUpAll(() async {
    auth = MockFirebaseAuth();
    firestore = FakeFirebaseFirestore();
    documentReference = firestore.collection('users').doc();
    await documentReference.set(
      tUser.copyWith(uid: documentReference.id).toMap(),
    );
    storage = MockFirebaseStorage();
    mockUser = MockUser()..uid = documentReference.id;
    userCredential = MockUserCredential(mockUser);
    remoteDataSource = CourseRemoteDataSourceImpl(
      firestore: firestore,
      storage: storage,
      auth: auth,
    );

    when(() => auth.currentUser).thenReturn(mockUser);
  });

  group('addCourse', () {
    test(
      'should add the given course to the firestore collection',
      () async {
        final course = CourseModel.empty();

        await remoteDataSource.addCourse(course);

        final firestoreData = await firestore.collection('courses').get();
        expect(firestoreData.docs.length, 1);

        final courseRef = firestoreData.docs.first;
        expect(courseRef.data()['id'], courseRef.id);

        final groupData = await firestore.collection('groups').get();
        expect(groupData.docs.length, 1);

        final groupRef = groupData.docs.first;
        expect(groupRef.data()['id'], groupRef.id);

        expect(courseRef.data()['groupId'], groupRef.id);
        expect(groupRef.data()['courseId'], courseRef.id);
      },
    );
  });

  group('getCourses', () {
    test('should return a List<Course>', () async {
      final firstDate = DateTime.now();
      final secondDate = DateTime.now().add(const Duration(seconds: 20));

      final expectedCourses = [
        CourseModel.empty().copyWith(
          createdAt: firstDate,
        ),
        CourseModel.empty().copyWith(
          createdAt: secondDate,
          id: '1',
          title: 'Course 1',
        ),
      ];

      for (final course in expectedCourses) {
        await firestore.collection('courses').add(course.toMap());
      }

      final result = await remoteDataSource.getCourses();

      expect(result, expectedCourses);
    });
  });
}
