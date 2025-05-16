import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsapp/screens/chat.dart';
import 'package:whatsapp/widgets/variables.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  int filter = 0;
  bool all = true;
  bool unread = false;
  bool read = false;
  List<String> choiceMsg = ["All", "Unread", "Read"];
  String selectedChoice = 'All';
  bool filters = false;
  Color conColor = const Color.fromRGBO(76, 175, 80, 0.2);
  Color textColor = const Color.fromARGB(255, 185, 244, 187);

  List<String> timestamp = ['Yesterday', '6/12/24', '12:56 pm'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.lightBlack,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Removes focus and hides keyboard
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 45.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Variables.lightGrey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  cursorColor: Variables.darkgreen,
                  style: TextStyle(color: Variables.white, fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Ask Meta AI or Search',
                    hintStyle: TextStyle(
                        color: Variables.white.withOpacity(0.6), fontSize: 15),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Variables.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 23.0,
              ),
              Row(
                children: [
                  const SizedBox(width: 10.0,),
                  SizedBox(
                    height: 28,
                    child: ListView.builder(
                        itemCount: choiceMsg.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedChoice = choiceMsg[index];
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 5.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                  color: selectedChoice == choiceMsg[index]
                                      ? conColor
                                      : null,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                      width: selectedChoice == choiceMsg[index]
                                          ? 0.0
                                          : 0.4,
                                      color: Colors.white.withOpacity(0.2))),
                              child: Center(
                                  child: Text(
                                choiceMsg[index],
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: selectedChoice == choiceMsg[index]
                                        ? textColor
                                        : Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 30.0, 0.0, 15.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.archive_outlined,
                      color: Variables.white.withOpacity(0.6),
                      size: 24,
                    ),
                    const SizedBox(
                      width: 28.0,
                    ),
                    Text(
                      'Archived',
                      style: TextStyle(
                          color: Variables.white.withOpacity(0.6),
                          letterSpacing: 1.0,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return buildChat(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildChat(int index) {
    final data = Random();
    var val = timestamp[data.nextInt(timestamp.length)];
    print(val);
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Chat()));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 14.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                info();
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Variables.lightGrey,
                  image: const DecorationImage(
                      image: AssetImage('assets/images/Mahi.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(
              width: 13.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dev Team',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Variables.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        val,
                        // '6/12/24',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Variables.lightGrey.withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi...',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Variables.white.withOpacity(0.8),
                            fontSize: 14),
                      ),
                      if (index < 3) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(
                            Icons.push_pin_rounded,
                            size: 18,
                            color: Variables.lightGrey.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void info() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 355,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/Mahi.jpg',
                    fit: BoxFit.cover,
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    height: 50,
                    color: Variables.lightBlack,
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Icon(
                          Icons.message,
                          color: Colors.green,
                          size: 28,
                        )),
                        Expanded(
                            child: Icon(
                          Icons.call_outlined,
                          color: Colors.green,
                          size: 28,
                        )),
                        Expanded(
                            child: Icon(
                          Icons.videocam,
                          color: Colors.green,
                          size: 30,
                        )),
                        Expanded(
                            child: Icon(
                          Icons.info_outline,
                          color: Colors.green,
                          size: 28,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        'Dev Team',
                        style: TextStyle(
                            color: Variables.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
