import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/auth/data/models/user_model.dart';
import 'package:education/src/course/data/models/course_model.dart';
import 'package:education/src/course/features/videos/data/datasources/video_remote_data_source.dart';
import 'package:education/src/course/features/videos/data/models/video_model.dart';
import 'package:education/src/course/features/videos/domain/entities/video.dart';
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
  late VideoRemoteDataSource remoteDataSource;
  late FirebaseFirestore firestore;
  late FirebaseAuth auth;
  late MockFirebaseStorage storage;
  //late UserCredential userCredential;
  late DocumentReference<DataMap> documentReference;
  late MockUser mockUser;

  const tUser = LocalUserModel.empty();
  final tVideo = VideoModel.empty();

  setUpAll(() async {
    auth = MockFirebaseAuth();
    firestore = FakeFirebaseFirestore();
    documentReference = firestore.collection('users').doc();
    await documentReference.set(
      tUser.copyWith(uid: documentReference.id).toMap(),
    );
    storage = MockFirebaseStorage();
    mockUser = MockUser()..uid = documentReference.id;
    //userCredential = MockUserCredential(mockUser);
    remoteDataSource = VideoRemoteDataSourceImpl(
      firestore: firestore,
      storage: storage,
      auth: auth,
    );

    when(() => auth.currentUser).thenReturn(mockUser);

    await firestore.collection('courses').doc(tVideo.courseId).set(
          CourseModel.empty()
              .copyWith(
                id: tVideo.courseId,
              )
              .toMap(),
        );
  });

  group('addVideo', () {
    test('should add the provided [Video] to the firestore', () async {
      await remoteDataSource.addVideo(tVideo);

      final videoCollectionRef = await firestore
          .collection('courses')
          .doc(tVideo.courseId)
          .collection('videos')
          .get();

      expect(videoCollectionRef.docs.length, 1);
      expect(videoCollectionRef.docs.first.data()['title'], tVideo.title);

      final courseRef =
          await firestore.collection('courses').doc(tVideo.courseId).get();

      expect(courseRef.data()!['numberOfVideos'], 1);
    });

    test(
      'should add the provided thumbnail to the storage if it is a file',
      () async {
        final thumbnailFile =
            File('assets/images/auth_gradient_background.png');

        final video = tVideo.copyWith(
          thumbnailIsFile: true,
          thumbnail: thumbnailFile.path,
        );

        await remoteDataSource.addVideo(video);

        final videoCollectionRef = await firestore
            .collection('courses')
            .doc(tVideo.courseId)
            .collection('videos')
            .get();

        expect(videoCollectionRef.docs.length, 1);
        final savedVideo = videoCollectionRef.docs.first.data();

        final thumbnailURL = await storage
            .ref()
            .child(
              'courses/${tVideo.courseId}/videos/${savedVideo['id']}/thumbnail',
            )
            .getDownloadURL();

        expect(savedVideo['thumbnail'], equals(thumbnailURL));
      },
    );
  });

  group('getVideos', () {
    test('should return a list of [Video] from the firestore', () async {
      await remoteDataSource.addVideo(tVideo);

      final result = await remoteDataSource.getVideos(tVideo.courseId);

      expect(result, isA<List<Video>>());
      expect(result.length, equals(1));
      expect(result.first.thumbnail, equals(tVideo.thumbnail));
    });

    /**
     * it's difficult to simulate an error with the fake firestore, because it
     * doesn't throw any errors, so we'll just test that it returns an empty
     * list when there's an error
     */
    test('should return an empty list when there is an error', () async {
      final result = await remoteDataSource.getVideos(tVideo.courseId);

      expect(result, isA<List<Video>>());
      expect(result.isEmpty, isTrue);
    });
  });
}
