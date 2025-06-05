import 'package:flutter/material.dart';
import 'package:whatsapp/screens/statuss.dart';
import 'package:whatsapp/widgets/variables.dart';

class Updates extends StatefulWidget {
  const Updates({super.key});

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  bool isViewed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Status',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                PopupMenuButton(
                  iconColor: Theme.of(context).colorScheme.onPrimary,
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
                        'Status Privacy',
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
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 13.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Statuss()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(width: 3.0, color: Colors.green),
                          shape: BoxShape.circle),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: const DecorationImage(
                              image: AssetImage('assets/images/Mahi.jpg'),
                              fit: BoxFit.cover),
                        ),
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
                              'My Status',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '12:58 AM',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5.0),
              child: Text(
                'Recent updates',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return buildStatus();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5.0, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Viewed updates',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.arrow_drop_down_sharp),
                  //   iconSize: 20,
                  //   color: Variables.lightGrey.withOpacity(0.8),
                  //   padding: EdgeInsets.all(0),
                  // )
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isViewed = !isViewed;
                      });
                    },
                    child: Icon(
                      !isViewed
                          ? Icons.arrow_drop_down_sharp
                          : Icons.arrow_drop_up_sharp,
                      size: 25,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: isViewed,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.linear,
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return buildStatus();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Channels',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w500),
                  ),
                  PopupMenuButton(
                    // iconColor: Variables.white,
                    iconSize: 25,
                    icon: const Icon(Icons.add),
                    color: Theme.of(context).colorScheme.secondary,
                    position: PopupMenuPosition.under,
                    popUpAnimationStyle: AnimationStyle(
                        curve: Curves.easeInToLinear,
                        duration: const Duration(milliseconds: 600)),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        padding: const EdgeInsets.only(left: 20.0, right: 30),
                        child: Text(
                          'Create channel',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      PopupMenuItem(
                        padding: const EdgeInsets.only(left: 20.0, right: 30),
                        child: Text(
                          'Find channels',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Stay updated on topics that matter to you. Find channels to follow below',
                style: TextStyle(
                    fontSize: 13.0,
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 20.0),
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return buildChannels(context);
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.40,
              margin: const EdgeInsets.only(left: 15.0, top: 20.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Explore more',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 200.0,
            ),
          ],
        ),
      ),
    );
  }

  Container buildChannels(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      height: 180,
      margin: const EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 1.0,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/Mahi.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Icon(
                      Icons.verified,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'ChennaiIpl',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16.0,
                fontWeight: FontWeight.w500),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Follow',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.green,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildStatus() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
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
                      'My Status',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '12:58 AM',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme
                            .onPrimary.withOpacity(0.8),
                          fontSize: 14),
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
