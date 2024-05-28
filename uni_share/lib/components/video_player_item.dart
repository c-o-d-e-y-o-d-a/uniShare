import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem({super.key});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  final String videoUrl;
  late VideoPlayerController _videoPlayerController;

  _VideoPlayerItemState({required this.videoUrl});

  @override
  void initState(){
    super.initState();
     videoUrl;
    _videoPlayerController = VideoPlayerController.networkUrl(widget.videoUrl)..initialize().then((value) {
      _videoPlayerController.play();
      _videoPlayerController.setVolume(1);
      
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(controller)
    );
  }
}