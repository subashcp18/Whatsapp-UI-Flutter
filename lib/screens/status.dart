import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;

  // @override
  // void initState() {
  //   super.initState();

  //   // Initialize the VideoPlayerController with an online URL
  //   _controller = VideoPlayerController.asset(
  //     'assets/videos/videoplayback.mp4', // Replace with your video URL
  //   );

  //   // Initialize the controller and store the Future for later use
  //   _initializeVideoPlayerFuture = _controller.initialize();

  //   // Start playing the video automatically
  //   _controller.setLooping(true);
  //   _controller.play();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: FutureBuilder(
      //     future: _initializeVideoPlayerFuture,
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         // If the VideoPlayerController has finished initialization, use the controller to play the video
      //         return AspectRatio(
      //           aspectRatio: _controller.value.aspectRatio,
      //           child: VideoPlayer(_controller),
      //         );
      //       } else {
      //         // If the VideoPlayerController is still initializing, show a loading spinner
      //         return CircularProgressIndicator();
      //       }
      //     },
      //   ),
      // ),
    );
  }
}
