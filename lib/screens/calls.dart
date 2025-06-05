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
      backgroundColor: Theme.of(context).colorScheme.primary,
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
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 25.0),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    // image: const DecorationImage(
                    //     image: AssetImage('assets/images/Mahi.jpg'),
                    //     fit: BoxFit.cover),
                  ),
                  child: Icon(Icons.favorite,size: 20,color: Theme.of(context).colorScheme.primary,),
                ),
                const SizedBox(
                  width: 13.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Add Favorite',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
                            fontSize: 16,
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
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
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
      padding: const EdgeInsets.fromLTRB(15.0, 11.0, 20.0, 11.0),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
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
                      'Bala',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: missed?
                          Theme.of(context).colorScheme.onPrimary:const Color.fromARGB(255, 245, 95, 84),
                          fontSize: 18,
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
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          audio
              ? Icon(
                  Icons.call_outlined,
                  // color: Variables.white,
                  size: 23,
                )
              : Icon(
                  Icons.videocam_outlined,
                  // color: Variables.white,
                  size: 23,
                ),
        ],
      ),
    );
  }
}
