import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/screens/chatinfo.dart';
import 'package:whatsapp/widgets/variables.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController message = TextEditingController();
  List<Map> msg = [
    {"message": "Hiiii", "User": false}
  ];
  bool msgTyping = false;
  bool _emojiShowing = false;
  List<String> recordedFilePath = [];
  late RecorderController recorderController = RecorderController();
  late PlayerController playerController = PlayerController();
  final playerWaveStyle = PlayerWaveStyle();

  bool isRecording = false;
  bool voiceNote = false;
  dynamic waveFormData;
  // void record() async {
  //   final record = AudioRecorder();

  //   if (await record.hasPermission()) {
  //     await record.start(const RecordConfig(), path: 'aFullPath/myFile.m4a');

  //     final stream = await record
  //         .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
  //   }

  //   final path = await record.stop();

  //   await record.cancel();

  //   record.dispose();
  // }

  @override
  void initState() {
    super.initState();
    recorderController.checkPermission();
  }

  @override
  void dispose() {
    super.dispose();
    message.dispose();
    recorderController.dispose();
    playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Variables.lightBlack,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            color: Variables.lightBlack,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Variables.white,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Variables.lightGrey,
                        image: const DecorationImage(
                            image: AssetImage('assets/images/Mahi.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print('clicked');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatInfo()));
                        },
                        splashColor: Colors.white,
                        child: Text(
                          'Bala',
                          style: TextStyle(
                              color: Variables.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.videocam,
                      color: Variables.white,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Icon(
                      Icons.call,
                      color: Variables.white,
                      size: 27,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    PopupMenuButton(
                      iconColor: Variables.white,
                      iconSize: 30,
                      color: const Color.fromARGB(255, 42, 42, 42),
                      position: PopupMenuPosition.under,
                      popUpAnimationStyle: AnimationStyle(
                          curve: Curves.easeInToLinear,
                          duration: const Duration(milliseconds: 300)),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'Media,links, and docs',
                            style: TextStyle(
                                color: Variables.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'Search',
                            style: TextStyle(
                                color: Variables.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'Disappearing messages',
                            style: TextStyle(
                                color: Variables.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'Wallpaper',
                            style: TextStyle(
                                color: Variables.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'More',
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
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bmw.jpeg'),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        // buildChatUser(context, 'Hiiiii'),
                        // buildChat(context, 'Hiiiii'),
                        // buildChatUser(context,
                        //     'Hellooobkaajsajdoqjqdoqjdoqjdoqjdqjdoqjdqojdoqjdjaoaj'),
                        // buildChatUser(context, 'Hiiiii'),
                        // buildChat(context, 'Hiiiii'),
                        ListView.builder(
                            itemCount: msg.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              if (msg[index]["User"]) {
                                return buildChatUser(
                                    context, msg[index]["message"]);
                              }
                              return buildChat(context, msg[index]["message"]);
                            }),
                        ListView.builder(
                            itemCount: recordedFilePath.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return buildVoiceNoteUser(context, '', index);
                            }),

                        SizedBox(
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 60,
                    child: Container(
                      width: double.infinity,
                      // height: 50.0,
                      constraints: BoxConstraints(
                        minHeight: 50.0,
                        maxHeight: 200,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                  color: Variables.white,
                                  fontSize: 18,
                                  overflow: TextOverflow.clip),
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
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: 'Message',
                                hintStyle: TextStyle(
                                    color: Variables.lightGrey, fontSize: 18),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8),
                                prefixIcon: Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Variables.lightGrey,
                                ),
                                suffixIcon: Icon(
                                  Icons.link,
                                  size: 27,
                                  color: Variables.lightGrey,
                                ),
                              ),
                            ),
                          ),
                          if (message.text.isEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Variables.lightGrey,
                              ),
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
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 150),
                    curve: Curves.linear,
                    bottom: isRecording ? -15 : 10,
                    right: isRecording ? -15 : 10,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 150),
                      curve: Curves.linear,
                      height: isRecording ? 100 : 50,
                      width: isRecording ? 100 : 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Center(
                          child: message.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      msg.add({
                                        "message": message.text.toString(),
                                        "User": true
                                      });
                                      print("added");
                                      message.clear();
                                    });
                                  },
                                  child: Icon(Icons.send_rounded))
                              : GestureDetector(
                                  onLongPressStart: (details) {
                                    print("Button pressed");
                                    if (recorderController.hasPermission) {
                                      recorderController.record();
                                      setState(() {
                                        isRecording = true;
                                      });
                                      print(recorderController.isRecording);
                                    }
                                  },
                                  onLongPressEnd: (details) async {
                                    print("Button released");
                                    if (recorderController.isRecording) {
                                      String? path =
                                          await recorderController.stop();
                                      recordedFilePath?.add(path!);
                                      voiceNotePlayer(0);
                                    }
                                    setState(() {
                                      isRecording = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.mic,
                                    size: isRecording ? 40 : 25,
                                  ))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildChatUser(BuildContext context, String message) {
    return GestureDetector(
      onLongPress: () {},
      child: Container(
        width: double.infinity,
        // color: const Color.fromRGBO(86, 177, 234, 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Stack(
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 100),
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 7.0, top: 7.0, bottom: 7.0),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.30),
                    decoration: BoxDecoration(
                      color: Variables.chat,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, right: 5.0),
                      child: Text(
                        message,
                        maxLines: 10,
                        softWrap: true,
                        style: TextStyle(
                            color: Variables.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '12:46 PM',
                          style: TextStyle(
                              color: Variables.lightGrey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check,
                          color: Variables.lightGrey,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                width: 7,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(0)),
                  color: Variables.chat,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildChat(BuildContext context, String message) {
    return GestureDetector(
      onLongPress: () {},
      child: Container(
        width: double.infinity,
        //color: const Color.fromRGBO(86, 177, 234, 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
              clipper: TriangleClipper1(),
              child: Container(
                width: 7,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(0)),
                  color: Variables.chat,
                ),
              ),
            ),
            Flexible(
              child: Stack(
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 80),
                    padding: const EdgeInsets.only(
                        left: 7.0, right: 12.0, top: 7.0, bottom: 7.0),
                    // margin: EdgeInsets.only(
                    //     right: MediaQuery.of(context).size.width * 0.30),
                    decoration: BoxDecoration(
                      color: Variables.chat,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, left: 3.0),
                      child: Text(
                        message,
                        maxLines: 10,
                        softWrap: true,
                        style: TextStyle(
                            color: Variables.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '12:46 PM',
                          style: TextStyle(
                              color: Variables.lightGrey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
            ),
          ],
        ),
      ),
    );
  }

  buildVoiceNote(BuildContext context, String message) {
    return GestureDetector(
      onLongPress: () {},
      child: Container(
        width: double.infinity,
        //color: const Color.fromRGBO(86, 177, 234, 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
              clipper: TriangleClipper1(),
              child: Container(
                width: 7,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(0)),
                  color: Variables.chat,
                ),
              ),
            ),
            Flexible(
              child: Stack(
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 80),
                    padding: const EdgeInsets.only(
                        left: 7.0, right: 12.0, top: 7.0, bottom: 7.0),
                    // margin: EdgeInsets.only(
                    //     right: MediaQuery.of(context).size.width * 0.30),
                    decoration: BoxDecoration(
                      color: Variables.chat,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, left: 3.0),
                      child: Text(
                        message,
                        maxLines: 10,
                        softWrap: true,
                        style: TextStyle(
                            color: Variables.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '12:46 PM',
                          style: TextStyle(
                              color: Variables.lightGrey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
            ),
          ],
        ),
      ),
    );
  }

  buildVoiceNoteUser(BuildContext context, String message, int index) {
    return GestureDetector(
      onLongPress: () {},
      child: Container(
        width: double.infinity,
        // color: const Color.fromRGBO(86, 177, 234, 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Stack(
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 100),
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 7.0, top: 7.0, bottom: 7.0),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.30),
                    decoration: BoxDecoration(
                      color: Variables.chat,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Variables.lightGrey,
                            image: const DecorationImage(
                                image: AssetImage('assets/images/Mahi.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              voiceNote = !voiceNote;
                            });
                            if (voiceNote) {
                              await voiceNotePlayer(
                                  index); // ensure it's prepared
                              await playerController.startPlayer();
                            } else {
                              await playerController.pausePlayer();
                            }
                          },
                          child: Icon(
                            voiceNote
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            size: voiceNote ? 35 : 40,
                            color: Colors.grey,
                          ),
                        ),
                        AudioFileWaveforms(
                          size: Size(100, 20),
                          playerController: playerController,
                          playerWaveStyle: PlayerWaveStyle(
                            showSeekLine: false,
                            fixedWaveColor: Colors.grey,
                            liveWaveColor: Colors.blue,
                          ),
                          // waveformData: null,
                          waveformType: WaveformType.fitWidth,
                          // continuousWaveform: true,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, right: 5.0),
                          child: Text(
                            message,
                            maxLines: 10,
                            softWrap: true,
                            style: TextStyle(
                                color: Variables.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '12:46 PM',
                          style: TextStyle(
                              color: Variables.lightGrey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check,
                          color: Variables.lightGrey,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                width: 7,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(0)),
                  color: Variables.chat,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> voiceNotePlayer(int index) async {
    const waveStyle = PlayerWaveStyle();
    final samples = waveStyle.getSamplesForWidth(100);

    await playerController.preparePlayer(
      path: recordedFilePath[index],
      shouldExtractWaveform: true,
      noOfSamples: samples,
    );

    playerController.setVolume(1.0);
    playerController.setFinishMode(finishMode: FinishMode.stop);

    playerController.onCompletion.listen((_) {
      playerController.stopPlayer();
      setState(() {
        voiceNote = false;
      });
      
    });
    return;
  }

  // void voiceNotePlayer() async {
  //   final samples = playerWaveStyle.getSamplesForWidth(100);
  //   waveFormData =
  //       await playerController.extractWaveformData(path: recordedFilePath!);
  //   playerController.preparePlayer(
  //     path: recordedFilePath!,
  //     shouldExtractWaveform: true, // this is important!
  //     noOfSamples: samples,
  //   );
  //   playerController.setVolume(1.0);
  //   playerController.setFinishMode(finishMode: FinishMode.stop);
  //   playerController.onCompletion.listen((_) {
  //     print("Completed");
  //     playerController.stopPlayer();
  //     // playerController.setRefresh(true);
  //     setState(() {
  //       voiceNote = false;
  //     });
  //     // playerController.preparePlayer(path: recordedFilePath!,
  //     // shouldExtractWaveform: true, // this is important!
  //     // noOfSamples: samples,);
  //   });
  // }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TriangleClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
