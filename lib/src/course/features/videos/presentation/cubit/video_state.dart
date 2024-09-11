part of 'video_cubit.dart';

sealed class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

final class VideoInitial extends VideoState {
  const VideoInitial();
}

final class AddingVideo extends VideoState {
  const AddingVideo();
}

final class LoadingVideos extends VideoState {
  const LoadingVideos();
}

final class VideoAdded extends VideoState {
  const VideoAdded();
}

final class VideosLoaded extends VideoState {
  const VideosLoaded(this.videos);

  final List<Video> videos;

  @override
  List<Object> get props => [
        videos,
      ];
}

final class VideoError extends VideoState {
  const VideoError(this.message);

  final String message;

  @override
  List<Object> get props => [
        message,
      ];
}
