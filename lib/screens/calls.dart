import 'package:flutter/material.dart';
import 'package:whatsapp/widgets/variables.dart';

class Calls extends StatefulWidget {
  const Calls({super.key});

  @override
  State<Calls> createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.lightBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Favorites',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Variables.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              // PopupMenuButton(
              //   iconColor: Variables.white,
              //   iconSize: 30,
              //   color: const Color.fromARGB(255, 42, 42, 42),
              //   position: PopupMenuPosition.under,
              //   popUpAnimationStyle: AnimationStyle(
              //       curve: Curves.easeInToLinear,
              //       duration: const Duration(milliseconds: 600)),
              //   itemBuilder: (BuildContext context) => [
              //     PopupMenuItem(
              //       padding: const EdgeInsets.only(left: 20.0, right: 30),
              //       child: Text(
              //         'Status Privacy',
              //         style: TextStyle(
              //             color: Variables.white,
              //             fontSize: 16,
              //             fontWeight: FontWeight.w400),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    // image: const DecorationImage(
                    //     image: AssetImage('assets/images/Mahi.jpg'),
                    //     fit: BoxFit.cover),
                  ),
                  child: const Icon(Icons.favorite),
                ),
                const SizedBox(
                  width: 13.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Add to Favorites',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Variables.white,
                            fontSize: 18,
                            wordSpacing: -2.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Recent',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Variables.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          buildCalls(true, true),
          buildCalls(false, false),
        ],
      ),
    );
  }

  Padding buildCalls(bool audio, bool missed) {
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
            width: 17.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bala',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: missed?
                          Variables.white:const Color.fromARGB(255, 245, 95, 84),
                          fontSize: 19,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_outward_outlined,
                      color: missed?
                      Colors.green: const Color.fromARGB(255, 249, 89, 77),
                      size: 20,
                    ),
                    const SizedBox(width: 5.0,),
                    Text(
                      'Yesterday ,12:58 PM',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Variables.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          audio
              ? Icon(
                  Icons.call_outlined,
                  color: Variables.white,
                  size: 27,
                )
              : Icon(
                  Icons.videocam,
                  color: Variables.white,
                  size: 27,
                ),
        ],
      ),
    );
  }
}
