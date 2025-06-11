import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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
  bool cameraFront = false;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _currentCamera = cameras.first;
    initializeCamera(_currentCamera);
    // initializeCamera();
  }

  // void initializeCamera() async {
  //   _controller = CameraController(
  //     cameras[0],
  //     ResolutionPreset.medium,
  //   );
  //   _initializeControllerFuture = _controller.initialize();
  // }

  void initializeCamera(CameraDescription cameraDescription) {
    _controller = CameraController(cameraDescription, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  void toggleCamera() {
    final newCamera = (_currentCamera.lensDirection ==
            CameraLensDirection.front)
        ? cameras
            .firstWhere((cam) => cam.lensDirection == CameraLensDirection.back)
        : cameras.firstWhere(
            (cam) => cam.lensDirection == CameraLensDirection.front);

    _controller.dispose();
    _currentCamera = newCamera;
    initializeCamera(_currentCamera);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> _getFilePath(String extension) async {
    final directory = await getTemporaryDirectory();
    final filePath = join(directory.path, '${DateTime.now()}.$extension');
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.lightBlack,
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 9 / 16,
                    child: CameraPreview(_controller),
                  ),
                  AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin:
                                      EdgeInsets.only(left: 10.0, bottom: 15.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Icon(
                                      Icons.image_outlined,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 45,
                                  height: 45,
                                  margin:
                                      EdgeInsets.only(left: 20.0, bottom: 17.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Icon(
                                      Icons.filter_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                          right: 10.0, bottom: 15.0),
                                  child: Transform.rotate(
                                    angle: cameraFront? pi: -pi,
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.easeIn,
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            toggleCamera();
                                            setState(() {
                                              cameraFront = !cameraFront;
                                              // if (_currentCamera.lensDirection ==
                                              //     CameraLensDirection.front) {
                                              //   cameraFront = true;
                                              // } else {
                                              //   cameraFront = false;
                                              // }
                                            });
                                          },
                                          child: Icon(
                                            Icons.flip_camera_android,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.only(bottom: 10.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5.0),
                                shape: BoxShape.circle),
                            child: Center(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                curve: Curves.linear,
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(left: 10.0, top: 15.0),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15.0,
                    right: 10.0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          Icons.flash_off,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(bottom: 30.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "Photo",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
