import 'package:dartz/dartz.dart';
import 'package:education/src/course/features/videos/data/datasources/video_remote_data_source.dart';
import 'package:education/src/course/features/videos/data/models/video_model.dart';
import 'package:education/src/course/features/videos/data/repos/video_repo_impl.dart';
import 'package:education/src/course/features/videos/domain/entities/video.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVideoRemoteDataSource extends Mock implements VideoRemoteDataSource {}

void main() {
  late VideoRemoteDataSource remoteDataSource;
  late VideoRepoImpl repoImpl;
  final tVideo = VideoModel.empty();

  setUp(() {
    remoteDataSource = MockVideoRemoteDataSource();
    repoImpl = VideoRepoImpl(remoteDataSource);
    registerFallbackValue(tVideo);
  });

  group('addVideo', () {
    test(
        'should complete successfully when call to remote source is '
        'successful', () async {
      when(() => remoteDataSource.addVideo(any())).thenAnswer(
        (_) async => Future.value(),
      );
    });
  });

  group('getVideos', () {
    test('should return [List<Video>] when call to remote source is successful',
        () async {
      when(() => remoteDataSource.getVideos(any())).thenAnswer(
        (_) async => [tVideo],
      );

      final result = await repoImpl.getVideos('courseId');

      expect(result, isA<Right<dynamic, List<Video>>>());
      verify(() => remoteDataSource.getVideos('courseId')).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
