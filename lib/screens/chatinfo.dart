import 'package:flutter/material.dart';
import 'package:whatsapp/widgets/variables.dart';

class ChatInfo extends StatefulWidget {
  const ChatInfo({super.key});

  @override
  State<ChatInfo> createState() => _ChatInfoState();
}

class _ChatInfoState extends State<ChatInfo> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool chatLock = false;
  bool isScrolled = false;
  bool scrolling = false;
  bool dp = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset.clamp(0, 200);
      if (_scrollOffset.toInt() > 40) {
        isScrolled = true;
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
    double translateX = -_scrollOffset * 0.65;
    double translateY = -_scrollOffset * 0.09;
    double scale = 1.0 - (_scrollOffset / 200) * 0.5;
    double size = (MediaQuery.of(context).size.width * 0.26) * scale;
    Color containerColor =
        Theme.of(context).colorScheme
      .primary.withOpacity((_scrollOffset * 0.005).clamp(0, 1));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // !isScrolled
                        const SizedBox(
                          height: 10.0,
                        ),
                        // !dp
                        //     ?
                        // AnimatedContainer(
                        //   duration: Duration(milliseconds: 800),
                        //   curve: Curves.easeInOut,
                        //   width: scrolling
                        //       ? 40
                        //       : MediaQuery.of(context).size.width * 0.28,
                        //   height: scrolling
                        //       ? 40
                        //       : MediaQuery.of(context).size.width * 0.28,
                        //   transform: Matrix4.translationValues(
                        //     scrolling ? -115 : 0,
                        //     scrolling ? -5 : 0,
                        //     0,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: Variables.lightGrey,
                        //     image: const DecorationImage(
                        //         image: AssetImage('assets/images/Mahi.jpg'),
                        //         fit: BoxFit.cover),
                        //   ),
                        // ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: MediaQuery.of(context).size.width * 0.28,
                        ),
                        Text(
                          'Bala',
                          style: TextStyle(
                              color:Theme.of(context).colorScheme.onPrimary,
                              fontSize: 23.0,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '+ 91  77083 64024',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
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
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                        width: 1.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.call_outlined,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      Text(
                                        "Audio",
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
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
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                        width: 1.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.videocam_outlined,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      Text(
                                        "Video",
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
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
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                        width: 1.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.currency_exchange_sharp,
                                        color: Colors.green,
                                        size: 23,
                                      ),
                                      Text(
                                        "Pay",
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
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
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                        width: 1.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.search_rounded,
                                        color: Colors.green,
                                        size: 25,
                                        weight: 115.0,
                                      ),
                                      Text(
                                        "Search",
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
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
                    color: Theme.of(context).colorScheme.surfaceContainer,
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
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          'July 10, 2024',
                          style: TextStyle(
                            fontSize: 13,
                            color:Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Theme.of(context).colorScheme.surfaceContainer,
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
                              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Text('123',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                            )),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
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
                    color:Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 40,
                        child: Icon(
                          Icons.notifications_none,
                          size: 24,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme
                                .onPrimary.withOpacity(0.9),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 40,
                        child: Icon(
                          Icons.image_outlined,
                          size: 24,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Media Visibility',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme
                                .onPrimary.withOpacity(0.9),
                              fontSize: 16.0,
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
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 40,
                        child: Icon(
                          Icons.lock_outlined,
                          size: 24,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Encryption',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme
                                    .onPrimary.withOpacity(0.9),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Messages and calls are end-to-end encrypted. Tap to verify',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSecondary,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 40,
                        child: Icon(
                          Icons.access_time_rounded,
                          size: 24,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Disappearing messages',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme
                                    .onPrimary.withOpacity(0.9),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Off',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSecondary,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 40,
                        child: Icon(
                          Icons.screen_lock_portrait,
                          size: 24,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chat lock',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme
                                    .onPrimary.withOpacity(0.9),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Lock and hide this chat on this device',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSecondary,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Switch(
                            value: chatLock,
                            inactiveThumbColor: Variables.lightGrey,
                            activeColor: Theme.of(context).colorScheme.primary,
                            // focusColor: Colors.black,
                            activeTrackColor: Colors.green,
                            inactiveTrackColor: Theme.of(context).colorScheme.primary,
                            onChanged: (value) {
                              setState(() {
                                chatLock = !chatLock;
                              });
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Theme.of(context).colorScheme.surfaceContainer,
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
                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
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
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: 40,
                        child: Icon(
                          Icons.favorite_border,
                          size: 24,
                          color: Variables.lightGrey.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Add to favourites',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme
                                .onPrimary.withOpacity(0.9),
                              fontSize: 16.0,
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
                        height: 40,
                        child: Icon(
                          Icons.block_flipped,
                          size: 24,
                          color: Variables.red,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Block Bala',
                          style: TextStyle(
                              color: Variables.red,
                              fontSize: 16.0,
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
                        height: 40,
                        child: Icon(
                          Icons.thumb_down_alt_outlined,
                          size: 24,
                          color: Variables.red,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Report Bala',
                          style: TextStyle(
                              color: Variables.red,
                              fontSize: 16.0,
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
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: containerColor,
                width: double.infinity,
                padding:
                    const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    isScrolled
                        ? Expanded(
                            child: Text(
                              "Bala",
                              style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          )
                        : Spacer(),
                    PopupMenuButton(
                      // iconColor: Variables.white,
                      iconSize: 25,
                      color: Theme.of(context).colorScheme.secondary,
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
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'Sdit',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'View in address book',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.only(left: 20.0, right: 30),
                          child: Text(
                            'Verify security code',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
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
            Positioned(
              top: 10,
              left:
                  MediaQuery.of(context).size.width / 2 - size / 2 + translateX,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Variables.lightGrey,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Mahi.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
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
            width: 42,
            height: 42,
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
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
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
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 13,
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
