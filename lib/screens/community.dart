import 'package:flutter/material.dart';
import 'package:whatsapp/widgets/variables.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.lightBlack,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  child: Stack(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Variables.lightGrey,
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/Mahi.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Variables.lightBlack,
                                width: 1.5,
                              ),
                              color: Colors.green),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Variables.lightBlack,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 13.0,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'New Community',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Variables.white.withOpacity(0.9),
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildCommunity() {
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
                      'My Status',
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
                      '12:58 AM',
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
        ],
      ),
    );
  }
}
