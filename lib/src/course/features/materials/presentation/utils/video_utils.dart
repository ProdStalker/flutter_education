import 'package:education/core/extensions/string_extensions.dart';
import 'package:education/core/utils/core_utils.dart';
import 'package:education/src/course/features/videos/data/models/video_model.dart';
import 'package:education/src/course/features/videos/domain/entities/video.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_metadata/youtube_metadata.dart';

class VideoUtils {
  const VideoUtils._();

  static Future<Video?> getVideoFromYT(
    BuildContext context, {
    required String url,
  }) async {
    void showSnack(String message) {
      CoreUtils.showSnackBar(context, message);
    }

    try {
      final metadata = await YoutubeMetaData.getData(url);
      if (metadata.thumbnailUrl == null ||
          metadata.title == null ||
          metadata.authorName == null) {
        final missingData = <String>[];
        if (metadata.thumbnailUrl == null) {
          missingData.add('Thumbnail');
        }
        if (metadata.title == null) {
          missingData.add('Title');
        }
        if (metadata.authorName == null) {
          missingData.add('Author name');
        }
        var missingDataText = missingData
            .fold(
              '',
              (previousValue, element) => '$previousValue$element, ',
            )
            .trim();
        missingDataText =
            missingDataText.substring(0, missingDataText.length - 1);
        final message = 'Could not get video. Please try again\n'
            'The missing data is: $missingDataText';
        showSnack(message);
        return null;
      }

      return VideoModel.empty().copyWith(
        thumbnail: metadata.thumbnailUrl,
        videoURL: url,
        title: metadata.title,
        tutor: metadata.authorName,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnack('PLEASE TRY AGAIN\n$e');
      return null;
    }
  }

  static Future<void> playVideo(BuildContext context, String videoUrl) async {
    if (videoUrl.isYoutubeVideo) {
      if (!await launchUrl(
        Uri.parse(videoUrl),
        mode: LaunchMode.externalApplication,
      )) {
        // ignore: use_build_context_synchronously
        CoreUtils.showSnackBar(context, 'Could not launch $videoUrl');
      }
    } else {
      // context.push(VideoPlayerView())
    }
  }
}
