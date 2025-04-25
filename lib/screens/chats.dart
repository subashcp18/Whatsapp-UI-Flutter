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
  Color firstconColor = const Color.fromRGBO(76, 175, 80, 0.2);
  Color firsttextColor = Colors.green;
  Color secondconColor = Colors.white.withOpacity(0.2);
  Color secondtextColor = Colors.white.withOpacity(0.5);
  Color thirdconColor = Colors.white.withOpacity(0.2);
  Color thirdtextColor = Colors.white.withOpacity(0.5);

  List<String> timestamp = ['Yesterday', '6/12/24', '12:56 pm'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.lightBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50.0,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Variables.input,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                cursorColor: Variables.darkgreen,
                style: TextStyle(color: Variables.white, fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Variables.white, fontSize: 18),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Variables.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    filterColor(0);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                    decoration: BoxDecoration(
                      color: firstconColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      'All',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: firsttextColor,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    filterColor(1);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                    decoration: BoxDecoration(
                      color: secondconColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      'Unread',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: secondtextColor,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    filterColor(2);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                    decoration: BoxDecoration(
                      color: thirdconColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      'Read',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: thirdtextColor,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.archive_outlined,
                    color: Variables.white,
                    size: 28,
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    'Archived',
                    style: TextStyle(
                        color: Variables.white,
                        letterSpacing: 1.0,
                        fontSize: 18.0,
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
    );
  }

  void filterColor(int index) {
    if (index == 0) {
      setState(() {
        firstconColor = const Color.fromRGBO(76, 175, 80, 0.2);
        firsttextColor = Colors.green;
        secondconColor = Colors.white.withOpacity(0.2);
        secondtextColor = Colors.white.withOpacity(0.5);
        thirdconColor = Colors.white.withOpacity(0.2);
        thirdtextColor = Colors.white.withOpacity(0.5);
      });
    } else if (index == 1) {
      setState(() {
        secondconColor = const Color.fromRGBO(76, 175, 80, 0.2);
        secondtextColor = Colors.green;
        firstconColor = Colors.white.withOpacity(0.2);
        firsttextColor = Colors.white.withOpacity(0.5);
        thirdconColor = Colors.white.withOpacity(0.2);
        thirdtextColor = Colors.white.withOpacity(0.5);
      });
    } else {
      setState(() {
        thirdconColor = const Color.fromRGBO(76, 175, 80, 0.2);
        thirdtextColor = Colors.green;
        secondconColor = Colors.white.withOpacity(0.2);
        secondtextColor = Colors.white.withOpacity(0.5);
        firstconColor = Colors.white.withOpacity(0.2);
        firsttextColor = Colors.white.withOpacity(0.5);
      });
    }
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
        padding: const EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                info();
              },
              child: Container(
                width: 52,
                height: 52,
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
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        val,
                        // '6/12/24',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Variables.lightGrey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi...',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Variables.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      if (index < 3) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(
                            Icons.push_pin,
                            size: 20,
                            color: Variables.lightGrey,
                          ),
                        ),
                      ]
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
