import 'package:flutter/material.dart';
import 'package:tok_tik/domain/entities/video_post.dart';
import 'package:tok_tik/domain/repository/video_post_repository.dart';

class DiscoverProvider extends ChangeNotifier {

  final VideoPostRepository videoPostRepository;

  DiscoverProvider({required this.videoPostRepository});

  bool initialLoading = true;
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    //await Future.delayed(const Duration(seconds: 2));

    /* final List<VideoPost> newVideos = videoPosts
        .map((video) => LocalVideoModel.fromJsonMap(video).toVideoPostEntity())
        .toList(); */
    final newVideo = await videoPostRepository.getTrendingVideosByPage(1);
    videos.addAll(newVideo);
    initialLoading = false;
    notifyListeners();
  }
}
