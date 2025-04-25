import 'package:flutter/material.dart';
import 'package:whatsapp/widgets/variables.dart';

class ChatInfo extends StatefulWidget {
  const ChatInfo({super.key});

  @override
  State<ChatInfo> createState() => _ChatInfoState();
}

class _ChatInfoState extends State<ChatInfo> {
  ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool chatLock = false;
  bool isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      print(_scrollOffset);
      if (_scrollOffset.toInt() > 180) {
        isScrolled = true;
        print("scrolleddd");
      } else {
        isScrolled = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = 125 - (_scrollOffset * 0.35).clamp(0, 100);
    double circlePosition = 100 - (_scrollOffset * 0.6).clamp(0, 100);
    Color containerColor =
        Colors.black.withOpacity((_scrollOffset * 0.005).clamp(0, 1));
    return Scaffold(
      backgroundColor: Variables.lightBlack,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // !isScrolled
                        //     ? Container(
                        //         width: MediaQuery.of(context).size.width * 0.30,
                        //         height:
                        //             MediaQuery.of(context).size.width * 0.30,
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color: Variables.lightGrey,
                        //           image: const DecorationImage(
                        //               image:
                        //                   AssetImage('assets/images/Mahi.jpg'),
                        //               fit: BoxFit.cover),
                        //         ),
                        //       )
                        //     : 
                        Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                height:
                                    MediaQuery.of(context).size.width * 0.30,
                              ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Bala',
                          style: TextStyle(
                              color: Variables.white,
                              fontSize: 23.0,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '+ 91  77083 64024',
                          style: TextStyle(
                              color: Variables.white,
                              fontSize: 17.0,
                              wordSpacing: -2.0,
                              fontWeight: FontWeight.w400),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 75,
                                  width: 70,
                                  margin: EdgeInsets.all(3.0),
                                  padding: EdgeInsets.symmetric(vertical: 3.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    border: Border.all(
                                        color: Variables.lightGrey
                                            .withOpacity(0.4),
                                        width: 1.5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.call_outlined,
                                        color: Colors.green,
                                        size: 28,
                                      ),
                                      Text(
                                        "Audio",
                                        style: TextStyle(
                                            color: Variables.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 75,
                                  width: 70,
                                  margin: EdgeInsets.all(3.0),
                                  padding: EdgeInsets.symmetric(vertical: 3.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    border: Border.all(
                                        color: Variables.lightGrey
                                            .withOpacity(0.4),
                                        width: 1.5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.videocam_outlined,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      Text(
                                        "Video",
                                        style: TextStyle(
                                            color: Variables.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 75,
                                  width: 70,
                                  margin: EdgeInsets.all(3.0),
                                  padding: EdgeInsets.symmetric(vertical: 3.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    border: Border.all(
                                        color: Variables.lightGrey
                                            .withOpacity(0.4),
                                        width: 1.5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.currency_exchange_sharp,
                                        color: Colors.green,
                                        size: 26,
                                      ),
                                      Text(
                                        "Pay",
                                        style: TextStyle(
                                            color: Variables.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 75,
                                  width: 70,
                                  margin: EdgeInsets.all(3.0),
                                  padding: EdgeInsets.symmetric(vertical: 3.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    border: Border.all(
                                        color: Variables.lightGrey
                                            .withOpacity(0.4),
                                        width: 1.5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.search_rounded,
                                        color: Colors.green,
                                        size: 30,
                                        weight: 115.0,
                                      ),
                                      Text(
                                        "Search",
                                        style: TextStyle(
                                            color: Variables.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Variables.darkBlack,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Focus on yourself ✨",
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: Variables.white),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          'July 10, 2024',
                          style: TextStyle(
                            color: Variables.lightGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Variables.darkBlack,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Media ,links and Docs',
                            style: TextStyle(
                              color: Variables.lightGrey,
                            ),
                          ),
                        ),
                        Text('123',
                            style: TextStyle(
                              color: Variables.lightGrey,
                            )),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: Variables.lightGrey,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.27,
                    margin: EdgeInsets.only(
                        left: 15.0, right: 5.0, top: 10.0, bottom: 20.0),
                    child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.width * 0.25,
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    image:
                                        AssetImage("assets/images/mahiii.jpg"),
                                    fit: BoxFit.cover)),
                          );
                        }),
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Variables.darkBlack,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 50,
                        child: Icon(
                          Icons.notifications_none,
                          size: 30,
                          color: Variables.lightGrey,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                              color: Variables.white,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 50,
                        child: Icon(
                          Icons.image_outlined,
                          size: 30,
                          color: Variables.lightGrey,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Text(
                          'Media Visibility',
                          style: TextStyle(
                              color: Variables.white,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Variables.darkBlack,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 50,
                        child: Icon(
                          Icons.lock_outlined,
                          size: 30,
                          color: Variables.lightGrey,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Encryption',
                              style: TextStyle(
                                  color: Variables.white,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Messages and calls are end-to-end encrypted. Tap to verify',
                              style: TextStyle(
                                color: Variables.lightGrey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 50,
                        child: Icon(
                          Icons.access_time_rounded,
                          size: 30,
                          color: Variables.lightGrey,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Disappearing messages',
                              style: TextStyle(
                                  color: Variables.white,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Off',
                              style: TextStyle(
                                color: Variables.lightGrey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 50,
                        child: Icon(
                          Icons.screen_lock_portrait,
                          size: 30,
                          color: Variables.lightGrey,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chat lock',
                              style: TextStyle(
                                  color: Variables.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Lock and hide this chat on this device',
                              style: TextStyle(
                                color: Variables.lightGrey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                          value: chatLock,
                          inactiveThumbColor: Variables.lightGrey,
                          focusColor: Colors.black,
                          activeTrackColor: Colors.green,
                          inactiveTrackColor: Variables.lightBlack,
                          onChanged: (value) {
                            setState(() {
                              chatLock = !chatLock;
                            });
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Variables.darkBlack,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 10.0, bottom: 10.0),
                    child: Column(
                      children: [
                        Text(
                          '3 Groups in common',
                          style: TextStyle(
                            color: Variables.lightGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildGroups(),
                  buildGroups(),
                  buildGroups(),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Variables.darkBlack,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 50,
                        child: Icon(
                          Icons.favorite_border,
                          size: 30,
                          color: Variables.lightGrey,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Text(
                          'Add to favourites',
                          style: TextStyle(
                              color: Variables.white,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 50,
                        child: Icon(
                          Icons.block_flipped,
                          size: 30,
                          color: Variables.red,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Text(
                          'Block Bala',
                          style: TextStyle(
                              color: Variables.red,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 50,
                        child: Icon(
                          Icons.thumb_down_alt_outlined,
                          size: 30,
                          color: Variables.red,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Text(
                          'Report Bala',
                          style: TextStyle(
                              color: Variables.red,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 25,
                    color: Variables.darkBlack,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                color: containerColor,
                width: double.infinity,
                padding:
                    const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                      width: 70,
                    ),
                    isScrolled?
                      Expanded(
                        child: Text(
                          "Bala",
                          style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w500,
                              color: Variables.white),
                        ),
                      ):Spacer(),
                    PopupMenuButton(
                      iconColor: Variables.white,
                      iconSize: 30,
                      color: const Color.fromARGB(255, 42, 42, 42),
                      position: PopupMenuPosition.under,
                      popUpAnimationStyle: AnimationStyle(
                          curve: Curves.easeInToLinear,
                          duration: const Duration(milliseconds: 600)),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'Share',
                            style: TextStyle(
                                color: Variables.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'Sdit',
                            style: TextStyle(
                                color: Variables.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'View in address book',
                            style: TextStyle(
                                color: Variables.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'Verify security code',
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
            ),
            AnimatedPositioned(
                top: circlePosition,
                left: circlePosition,
                child: Container(
                  height: circleSize,
                  width: circleSize,
                  margin: EdgeInsets.only(top: 16, left: 45),
                  // width: MediaQuery.of(context).size.width * 0.30,
                  // height: MediaQuery.of(context).size.width * 0.30,
                  constraints: BoxConstraints(
                    minWidth: 50,
                    minHeight: 50,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Variables.lightGrey,
                    image: const DecorationImage(
                        image: AssetImage('assets/images/Mahi.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                duration: Duration(milliseconds: 150)),
            //  Positioned(
            //         top: 20,
            //         child: Text(
            //           "Bala",
            //           style: TextStyle(
            //               fontSize: 23.0,
            //               fontWeight: FontWeight.w500,
            //               color: Variables.white),
            //         ),
            //       ),
          ],
        ),
      ),
    );
  }

  buildGroups() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Variables.lightGrey,
              image: const DecorationImage(
                  image: AssetImage('assets/images/Mahi.jpg'),
                  fit: BoxFit.cover),
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
                      'My Group',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Variables.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Arun, Bala, Dhev, Narayanan ....',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Variables.lightGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
