import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp/main.dart';
import 'package:whatsapp/widgets/variables.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription _currentCamera;
  final TextEditingController message = TextEditingController();
  bool cameraInitialized = false;
  bool cameraFront = false;
  bool isPhoto = true;
  bool showContainer = true;
  bool _isRecording = false;
  bool hasTaken = false;
  String? path;

  final List<FlashMode> flashModes = [
    FlashMode.off,
    FlashMode.auto,
    FlashMode.always,
    FlashMode.torch,
  ];

  int _flashModeIndex = 0;

  int _recordDuration = 0;
  Timer? _timer;
  String duration = "00:00";

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _currentCamera = cameras.first;
    initializeCamera(_currentCamera);
    // initializeCamera();
  }

  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    _controller = CameraController(cameraDescription, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    setState(() {
      cameraInitialized = true;
    });
  }

  void toggleCamera() async {
    setState(() {
      cameraInitialized = false;
    });
    final newCamera = (_currentCamera.lensDirection ==
            CameraLensDirection.front)
        ? cameras
            .firstWhere((cam) => cam.lensDirection == CameraLensDirection.back)
        : cameras.firstWhere(
            (cam) => cam.lensDirection == CameraLensDirection.front);
    if (_controller.value.isInitialized) {
      await _controller.dispose();
    }
    setState(() {
      _currentCamera = newCamera;
    });
    await initializeCamera(_currentCamera);
  }

  void startRecordingTimer() {
    _recordDuration = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      _recordDuration++;
      formatTime(_recordDuration);
      print('Recording: $_recordDuration seconds');
    });
  }

  void formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    setState(() {
      duration = '$minutes:$secs';
    });
  }

// Call this when recording stops
  void stopRecordingTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> takePhoto() async {
    try {
      await _initializeControllerFuture;

      final XFile file = await _controller.takePicture();

      print('Photo saved to ${file.path}');
      setState(() {
        path = file.path;
        hasTaken = true;
      });
      // You can also use Image.file(File(file.path)) to display it
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  Future<void> startVideoRecording() async {
    try {
      await _initializeControllerFuture;
      await _controller.startVideoRecording();
      startRecordingTimer();
      setState(() {
        _isRecording = true;
        hasTaken = true;
      });
      print('Recording started');
    } catch (e) {
      print('Error starting video: $e');
    }
  }

  Future<void> stopVideoRecording() async {
    try {
      final XFile file = await _controller.stopVideoRecording();
      stopRecordingTimer();
      setState(() {
        _isRecording = false;
        duration = "00:00";
        path = file.path;
        hasTaken = true;
      });
      print('Video saved to ${file.path}');
      // Play with video_player package if needed
    } catch (e) {
      print('Error stopping video: $e');
    }
  }

  void toggleFlashMode() async {
    _flashModeIndex = (_flashModeIndex + 1) % flashModes.length;
    FlashMode newMode = flashModes[_flashModeIndex];

    try {
      await _controller.setFlashMode(newMode);
      setState(() {}); // to update icon or UI if needed
      print('Flash mode set to $newMode');
    } catch (e) {
      print('Error setting flash mode: $e');
    }
  }

  IconData _getFlashIcon(FlashMode mode) {
    switch (mode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.torch:
        return Icons.highlight; // or Icons.flashlight_on if available
      default:
        return Icons.flash_off;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Future<String> _getFilePath(String extension) async {
    final directory = await getTemporaryDirectory();
    final filePath = join(directory.path, '${DateTime.now()}.$extension');
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (hasTaken) {
          setState(() {
            hasTaken = false;
          });
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: !hasTaken
              ? FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 9 / 16,
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 16,
                                  child: cameraInitialized
                                      ? CameraPreview(_controller)
                                      : SizedBox(),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _isRecording
                                        ? SizedBox()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  margin: const EdgeInsets.only(
                                                      left: 10.0, top: 15.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      shape: BoxShape.circle),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: toggleFlashMode,
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  margin: const EdgeInsets.only(
                                                      right: 10.0, top: 15.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                    child: Icon(
                                                      _getFlashIcon(flashModes[
                                                          _flashModeIndex]),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    !_isRecording
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 60,
                                                height: 60,
                                                margin: const EdgeInsets.only(
                                                    left: 10.0, bottom: 15.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    shape: BoxShape.circle),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.image_outlined,
                                                    color: Colors.white,
                                                    size: 28,
                                                  ),
                                                ),
                                              ),
                                              // Container(
                                              //   width: 45,
                                              //   height: 45,
                                              //   margin: const EdgeInsets.only(
                                              //       left: 20.0, bottom: 17.0),
                                              //   decoration: BoxDecoration(
                                              //       color: Colors.black.withOpacity(0.3),
                                              //       shape: BoxShape.circle),
                                              //   child: const Center(
                                              //     child: Icon(
                                              //       Icons.filter_alt_outlined,
                                              //       color: Colors.white,
                                              //     ),
                                              //   ),
                                              // ),
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0, bottom: 15.0),
                                                child: Transform.rotate(
                                                  angle: cameraFront ? pi : -pi,
                                                  child: AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 1000),
                                                    curve: Curves.easeIn,
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        shape: BoxShape.circle),
                                                    child: Center(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          toggleCamera();
                                                          setState(() {
                                                            cameraFront =
                                                                !cameraFront;
                                                            // if (_currentCamera.lensDirection ==
                                                            //     CameraLensDirection.front) {
                                                            //   cameraFront = true;
                                                            // } else {
                                                            //   cameraFront = false;
                                                            // }
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Icons
                                                              .flip_camera_android,
                                                          color: Colors.white,
                                                          size: 28,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (isPhoto) {
                                        takePhoto();
                                      } else {
                                        if (_isRecording) {
                                          stopVideoRecording();
                                        } else {
                                          startVideoRecording();
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      margin:
                                          const EdgeInsets.only(bottom: 10.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _isRecording
                                                  ? Colors.red
                                                  : Colors.white,
                                              width: 5.0),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: _isRecording
                                            ? Container(
                                                width: 68,
                                                height: 68,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black
                                                        .withOpacity(0.2)),
                                                child: Icon(
                                                  Icons.stop_rounded,
                                                  color: Colors.red,
                                                  size: 40,
                                                ),
                                              )
                                            : AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 150),
                                                curve: Curves.linear,
                                                width: isPhoto ? 47 : 35,
                                                height: isPhoto ? 47 : 35,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                !isPhoto
                                    ? Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 35,
                                          width: 70,
                                          margin: EdgeInsets.only(top: 15.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 8.0),
                                          decoration: BoxDecoration(
                                            color: _isRecording
                                                ? Colors.red
                                                : Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Text(
                                              duration,
                                              style: TextStyle(
                                                  color: _isRecording
                                                      ? Colors.white
                                                      : Colors.grey
                                                          .withOpacity(0.8)),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.linear,
                                  alignment: Alignment.center,
                                  child: AnimatedPadding(
                                    duration: Duration(milliseconds: 150),
                                    curve: Curves.linear,
                                    padding: EdgeInsets.only(
                                        right: isPhoto
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45
                                            : 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (isPhoto) {
                                          setState(() {
                                            isPhoto = !isPhoto;
                                            showContainer = false;
                                          });
                                          Future.delayed(
                                              Duration(milliseconds: 150), () {
                                            setState(() {
                                              showContainer = true;
                                            });
                                          });
                                        }
                                      },
                                      child: Text(
                                        "Video",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                AnimatedAlign(
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.linear,
                                  alignment: Alignment.center,
                                  child: AnimatedPadding(
                                    duration: Duration(milliseconds: 150),
                                    curve: Curves.linear,
                                    padding: EdgeInsets.only(
                                        left: isPhoto
                                            ? 0
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (!isPhoto) {
                                          setState(() {
                                            isPhoto = !isPhoto;
                                            showContainer = false;
                                          });
                                        }
                                        Future.delayed(
                                            Duration(milliseconds: 150), () {
                                          setState(() {
                                            showContainer = true;
                                          });
                                        });
                                      },
                                      child: Text(
                                        "Photo",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: AnimatedOpacity(
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                    opacity: showContainer ? 1.0 : 0.0,
                                    child: Container(
                                      height: 35,
                                      width: 70,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Photo",
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 9 / 16,
                              child: Image.file(
                                File(path!),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          hasTaken = false;
                                        });
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        margin: const EdgeInsets.only(
                                            left: 10.0, top: 15.0),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            shape: BoxShape.circle),
                                        child: const Center(
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.only(
                                          right: 10.0, top: 15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Icon(
                                          Icons.hd,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.only(
                                          right: 10.0, top: 15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Icon(
                                          Icons.crop_rotate_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.only(
                                          right: 10.0, top: 15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Icon(
                                          Icons.sticky_note_2_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.only(
                                          right: 10.0, top: 15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Icon(
                                          Icons.text_fields_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.only(
                                          right: 10.0, top: 15.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 45.0,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Variables.input,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        cursorColor: Variables.darkgreen,
                                        controller: message,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            overflow: TextOverflow.clip),
                                        onChanged: (value) {},
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                          hintText: 'Add a caption...',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15.0,
                                                  vertical: 8),
                                          prefixIcon: Icon(
                                            Icons.emoji_emotions_outlined,
                                            color: Colors.white,
                                            size: 23,
                                          ),
                                          suffixIcon: Icon(
                                            Icons.link,
                                            size: 27,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "1",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 12.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 42,
                              width: 42,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Center(
                                child: Icon(
                                  Icons.done_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
