import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/features/videos/domain/entities/video.dart';
import 'package:education/src/course/features/videos/domain/repos/video_repo.dart';

class AddVideo extends FutureUsecaseWithParams<void, Video> {
  const AddVideo(this._repo);

  final VideoRepo _repo;

  @override
  ResultFuture<void> call(Video params) => _repo.addVideo(params);
}
