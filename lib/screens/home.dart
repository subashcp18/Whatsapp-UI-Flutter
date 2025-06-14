import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:whatsapp/screens/calls.dart';
import 'package:whatsapp/screens/camera.dart';
import 'package:whatsapp/screens/chats.dart';
import 'package:whatsapp/screens/community.dart';
import 'package:whatsapp/screens/settings.dart';
import 'package:whatsapp/screens/splash.dart';
import 'package:whatsapp/screens/updates.dart';
import 'package:whatsapp/widgets/variables.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController();
  int currentPageIndex = 0;
  String title = 'WhatsApp';

  void _goToPage(int pageIndex) {
    pageController.jumpToPage(pageIndex);
    titlee(pageIndex);
    // pageController.animateToPage(
    //   pageIndex,
    //   duration: Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
  }

  void titlee(int index) {
    setState(() {
      if (index == 0) {
        title = 'WhatsApp';
      } else if (index == 1) {
        title = 'Updates';
      } else if (index == 2) {
        title = 'Communities';
      } else {
        title = 'Calls';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Column(
            children: [
              const SizedBox(
                height: 3.0,
              ),
              Container(
                width: double.infinity,
                height: 90,
                padding: const EdgeInsets.only(left: 15),
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          //'WhatsApp',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary ==
                                    Colors.black87
                                ? title == "WhatsApp"
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onPrimary,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.qr_code_scanner,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 23,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Camera()));
                        },
                        child: Icon(
                          Icons.camera_alt_outlined,
                          // color: Theme.of(context).colorScheme.onPrimary,
                          size: 23,
                        ),
                      ),
                      if (currentPageIndex == 1 || currentPageIndex == 3) ...[
                        const SizedBox(
                          width: 15.0,
                        ),
                        Icon(
                          Icons.search,
                          // color: Theme.of(context).colorScheme.onPrimary,
                          size: 23,
                        ),
                      ],
                      PopupMenuButton(
                        // iconColor: Variables.white,
                        iconSize: 25,
                        // color: Theme.of(context).colorScheme.onPrimary,
                        position: PopupMenuPosition.under,
                        popUpAnimationStyle: AnimationStyle(
                            curve: Curves.easeInToLinear,
                            duration: const Duration(milliseconds: 600)),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 30),
                            child: Text(
                              'New Group',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          PopupMenuItem(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 30),
                            child: Text(
                              'New Broadcast',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          PopupMenuItem(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 30),
                            child: Text(
                              'Linked devices',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          PopupMenuItem(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 30),
                            child: Text(
                              'Starred messages',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          PopupMenuItem(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 30),
                            child: Text(
                              'Payments',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Settings()));
                            },
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 30.0),
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      currentPageIndex = index;
                      titlee(index);
                    });
                    print('page turned: $index');
                  },
                  children: const [
                    Chats(),
                    Updates(),
                    Community(),
                    Calls(),
                  ],
                ),
              ),
            ],
          ),
          // bottomNavigationBar: NavigationBar(
          //   onDestinationSelected: (int index) {
          //     setState(() {
          //       currentPageIndex = index;
          //       //pageController.jumpToPage(index);
          //       _goToPage(index);
          //     });
          //   },
          //   //backgroundColor: Variables.lightBlack,
          //   indicatorColor: Variables.green,
          //   selectedIndex: currentPageIndex,
          //   destinations: <Widget>[
          //     NavigationDestination(
          //       selectedIcon: const Icon(
          //         Icons.mark_unread_chat_alt,
          //         color: Colors.white,
          //       ),
          //       icon: Badge(
          //         label: const Text('2'),
          //         child: Icon(
          //           Icons.mark_unread_chat_alt_outlined,
          //           color: Variables.white,
          //         ),
          //       ),
          //       label: 'Chats',
          //     ),
          //     NavigationDestination(
          //       selectedIcon: Icon(
          //         Icons.track_changes_outlined,
          //         color: Variables.white,
          //       ),
          //       icon: Icon(
          //         Icons.track_changes_outlined,
          //         color: Variables.white,
          //       ),
          //       label: 'Updates',
          //     ),
          //     NavigationDestination(
          //       icon: Icon(
          //         Icons.person_4_rounded,
          //         color: Variables.white,
          //       ),
          //       label: 'Communities',
          //     ),
          //     NavigationDestination(
          //       selectedIcon: Icon(
          //         Icons.call,
          //         color: Variables.white,
          //       ),
          //       icon: Icon(
          //         Icons.call_outlined,
          //         color: Variables.white,
          //       ),
          //       label: 'Calls',
          //     ),
          //   ],
          // ),
          bottomNavigationBar: SafeArea(
            child: Container(
              height: 85,
              padding: EdgeInsets.only(top: 10.0),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _goToPage(0);
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 40,
                            decoration: currentPageIndex == 0
                                ? BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    borderRadius: BorderRadius.circular(23),
                                  )
                                : BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary),
                            child: Icon(
                              Icons.mark_unread_chat_alt_outlined,
                              // color: Variables.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Chats',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onPrimary),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _goToPage(1);
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 40,
                            decoration: currentPageIndex == 1
                                ? BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    borderRadius: BorderRadius.circular(23),
                                  )
                                : BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary),
                            child: Icon(
                              Icons.track_changes_outlined,
                              // color: Variables.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Updates',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onPrimary),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _goToPage(2);
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 40,
                            decoration: currentPageIndex == 2
                                ? BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    borderRadius: BorderRadius.circular(23),
                                  )
                                : BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary),
                            child: Icon(
                              Icons.person_4_rounded,
                              // color: Variables.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Communities',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _goToPage(3);
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 40,
                            decoration: currentPageIndex == 3
                                ? BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    borderRadius: BorderRadius.circular(23),
                                  )
                                : BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary),
                            child: Icon(
                              Icons.call_outlined,
                              // color: Variables.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Calls',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: currentPageIndex == 2
              ? Container()
              : FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.green,
                  child: (currentPageIndex == 0)
                      ? Icon(
                          Icons.messenger_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : (currentPageIndex == 1)
                          ? Icon(
                              Icons.camera_alt,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : Icon(
                              Icons.add_call,
                              color: Theme.of(context).colorScheme.primary,
                            ))
          // : FloatingActionButton(
          //     onPressed: () {},
          //     backgroundColor: Colors.green,
          //     child: (currentPageIndex == 2)
          //         ? Icon(Icons.messenger_rounded)
          //         : Icon(Icons.add_call)),
          ),
    );
  }
}
