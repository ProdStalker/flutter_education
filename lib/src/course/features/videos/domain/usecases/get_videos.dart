import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/features/videos/domain/entities/video.dart';
import 'package:education/src/course/features/videos/domain/repos/video_repo.dart';

class GetVideos extends UsecaseWithParams<List<Video>, String> {
  const GetVideos(this._repo);

  final VideoRepo _repo;

  @override
  ResultFuture<List<Video>> call(String params) {
    return _repo.getVideos(params);
  }
}
