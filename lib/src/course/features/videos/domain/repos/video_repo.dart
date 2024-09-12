import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/features/videos/domain/entities/video.dart';

abstract class VideoRepo {
  const VideoRepo();

  // We could make this a stream, but for the sakes of tutorials,
  // we'll keep it simple
  ResultFuture<List<Video>> getVideos(String courseId);

  ResultFuture<void> addVideo(Video video);
}
