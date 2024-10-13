import 'package:flutter/material.dart';
import 'package:tok_tik/domain/entities/video_post.dart';
import 'package:tok_tik/presentation/widgets/shared/video_button.dart';
import 'package:tok_tik/presentation/widgets/video/fullscreen_player.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;
  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final VideoPost videoPost = videos[index];
        return Stack(
          children: [
            //VideoPlayer
            SizedBox.expand(
                child: FullScreenPlayer(
              caption: videoPost.caption,
              videoUrl: videoPost.videoUrl,
            )),
            // FullScreenPlayer(video: videoPost),

            // Button
            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButton(
                video: videoPost,
              ),
            )
          ],
        );
      },
    );
  }
}
