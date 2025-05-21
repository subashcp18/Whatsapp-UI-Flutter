import 'dart:async';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp/widgets/variables.dart';

class Statuss extends StatefulWidget {
  const Statuss({super.key});

  @override
  State<Statuss> createState() => _StatussState();
}

class _StatussState extends State<Statuss> with TickerProviderStateMixin {
  final TextEditingController message = TextEditingController();
  List<FlickManager> flickManager = [];
  bool msgTyping = false;
  // late AnimationController controller;
  PageController pageController = PageController();
  double progress = 0.0;
  Timer? timer;
  List<String> videos = [
    'assets/videos/videoplayback.mp4',
    'assets/videos/waterpacket.mp4'
  ];
  // List<double?> progres = List<double?>.generate(2, (index) => null);
  List<double?> progres = [0.0, 0.0];
  List captions = ["💫", "✨"];
  int videoIndex = 0;
  int totalDuration = 0;
  int videoplayedindex = 0;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool isPressed = false;
  bool isLike = false;

  @override
  void initState() {
    super.initState();
    video();
    timerr();
  }

  void video() {
    AnimationController(
      vsync: this,
    );
    flickManager = videos
        .map((url) => FlickManager(
              videoPlayerController: VideoPlayerController.asset(url),
            ))
        .toList();
    flickManager[videoIndex].flickControlManager?.addListener(sendProgressData);
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  void timerr() {
    timer = Timer.periodic(Duration(microseconds: 0), (timer) {
      if (mounted) {
        sendProgressData();
      }
    });
  }

  void sendProgressData() async {
    if (!mounted) return;
    bool status = flickManager[videoIndex].flickVideoManager!.isVideoEnded;
    if (status) {
      print('Video ended');

      if (videoplayedindex >= flickManager.length) {
        print("if block");
        print("Video Played Index: $videoplayedindex");
        timer?.cancel();
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        if (!mounted) return;
        setState(() {
          progres[0] = progress;
        });
        print("else block");
        print("Video Played Index: $videoplayedindex");
        flickManager.forEach((manager) => manager.flickControlManager?.pause());
        pageController.nextPage(
            curve: Curves.linear, duration: Duration(milliseconds: 100));

        flickManager[videoIndex].flickControlManager?.play();
      }
    }
    if (!mounted) return;
    setState(() {
      int totalseconds = flickManager[videoIndex]
          .flickVideoManager!
          .videoPlayerValue!
          .duration
          .inSeconds;
      int currentseconds = flickManager[videoIndex]
          .flickVideoManager!
          .videoPlayerValue!
          .position
          .inSeconds;
      if (currentseconds < totalseconds) {
        progress = flickManager[videoIndex]
                .flickVideoManager!
                .videoPlayerValue!
                .position
                .inSeconds /
            flickManager[videoIndex]
                .flickVideoManager!
                .videoPlayerValue!
                .duration
                .inSeconds;
        if (progress != 0.0) {
          progres[videoIndex] = progress;
        }
      }
    });
  }

  void triggerVibration() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    } else {
      print('No vibration capability on this device');
    }
  }

  @override
  void dispose() {
    // Dispose all flick managers
    pageController.dispose();
    // controller.dispose();
    timer?.cancel();
    for (var manager in flickManager) {
      try {
        // Delay disposal slightly to ensure no ongoing notifications
        Future.delayed(Duration.zero, () {
          manager.dispose();
        });
      } catch (e) {
        print("Error disposing manager: $e");
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Remove focus when tapping outside
        },
        child: Scaffold(
          body: GestureDetector(
            onLongPress: () {
              setState(() {
                isPressed = true;
              });
              flickManager
                  .forEach((manager) => manager.flickControlManager?.pause());
            },
            onLongPressEnd: (details) {
              setState(() {
                isPressed = false;
              });
              flickManager[videoIndex].flickControlManager?.play();
            },
            onTapDown: (TapDownDetails details) {
              double screenWidth = MediaQuery.of(context).size.width;
              double tapPositionX = details.globalPosition.dx;
              if (tapPositionX < screenWidth / 2) {
                print('Left side tapped');
                pageController.previousPage(
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              } else {
                print('Right side tapped');
                pageController.nextPage(
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }
            },
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: flickManager.length,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      videoIndex = value;
                      videoplayedindex = value + 1;
                      print("Index: $value");
                      if (value == 1) {
                        progres[0] = 100.0;
                      } else {
                        progres[0] = 0.0;
                        progres[1] = 0.0;
                      }
                    });
                    // print("Index: $value");
                    // print("Played index: $videoplayedindex");
                    flickManager.forEach(
                        (manager) => manager.flickControlManager?.pause());
                    flickManager[videoIndex].flickControlManager?.replay();
                  },
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 200,
                      child: FlickVideoPlayer(
                        flickManager: flickManager[index],
                        flickVideoWithControls: FlickVideoWithControls(
                          controls: Container(),
                        ),
                      ),
                    );
                  },
                ),
                if (!isPressed) ...[
                  Positioned(
                    top: 27,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 3.0,
                        ),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progres[0],
                            minHeight: 3.0,
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progres[1],
                            minHeight: 3.0,
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 36,
                    left: 0,
                    right: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: Variables.white,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Variables.lightGrey,
                            image: const DecorationImage(
                                image: AssetImage('assets/images/Mahi.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bala",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                    color: Variables.white),
                              ),
                              Text(
                                "Yesterday ,7:31 AM",
                                style: TextStyle(
                                    wordSpacing: -2.0,
                                    fontSize: 12.0,
                                    color: Variables.white),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuButton(
                          iconColor: Variables.white,
                          iconSize: 25,
                          color: Variables.lightBlack,
                          position: PopupMenuPosition.under,
                          popUpAnimationStyle: AnimationStyle(
                              curve: Curves.easeInToLinear,
                              duration: const Duration(milliseconds: 600)),
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 50),
                              child: Text(
                                'Mute',
                                style: TextStyle(
                                    color: Variables.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            PopupMenuItem(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 30),
                              child: Text(
                                'Message',
                                style: TextStyle(
                                    color: Variables.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            PopupMenuItem(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 30),
                              child: Text(
                                'Voice call',
                                style: TextStyle(
                                    color: Variables.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            PopupMenuItem(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 30),
                              child: Text(
                                'Video call',
                                style: TextStyle(
                                    color: Variables.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            PopupMenuItem(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 30),
                              child: Text(
                                'View Contact',
                                style: TextStyle(
                                    color: Variables.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            PopupMenuItem(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 30),
                              child: Text(
                                'Report',
                                style: TextStyle(
                                    color: Variables.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.17,
                      color: Colors.black.withOpacity(0.4),
                      padding: EdgeInsets.only(top: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            captions[videoIndex],
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 10,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Variables.input,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: Variables.darkgreen,
                                    controller: message,
                                    focusNode: _focusNode,
                                    style: TextStyle(
                                        color: Variables.white, fontSize: 18),
                                    onChanged: (value) {
                                      if (value.isNotEmpty || value != null) {
                                        setState(() {
                                          msgTyping = true;
                                        });
                                      } else {
                                        setState(() {
                                          msgTyping = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText:
                                          _isFocused ? 'Message' : 'Reply',
                                      hintStyle: TextStyle(
                                          color: Variables.white,
                                          fontSize: 18),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 8),
                                      prefixIcon: _isFocused
                                          ? Icon(
                                              Icons.emoji_emotions_outlined,
                                              color: Variables.lightGrey,
                                            )
                                          : null,
                                      suffixIcon: _isFocused
                                          ? Icon(
                                              Icons.link,
                                              size: 27,
                                              color: Variables.lightGrey,
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                                if (_isFocused) ...[
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Variables.lightGrey,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                ],
                                const SizedBox(
                                  width: 5.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLike = !isLike;
                            });
                            triggerVibration();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Variables.input),
                            child: isLike
                                ? Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
