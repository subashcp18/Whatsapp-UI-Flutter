import 'package:flutter/material.dart';
import 'package:whatsapp/screens/theme.dart';
import 'package:whatsapp/widgets/variables.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isbio = false;
  bool showProfileContent = false;
  Map data = {
    "0": {
      "icon": Icons.key_outlined,
      "text": "Account",
      "subtext": "Security notifications, change number"
    },
    "1": {
      "icon": Icons.lock_outline,
      "text": "Privacy",
      "subtext": "Block contacts, disappearing messages"
    },
    "2": {
      "icon": Icons.face_4_rounded,
      "text": "Avatar",
      "subtext": "Create, edit, profile photo"
    },
    "3": {
      "icon": Icons.group,
      "text": "Lists",
      "subtext": "Manage people and groups"
    },
    "4": {
      "icon": Icons.chat_bubble_outline_rounded,
      "text": "Chats",
      "subtext": "Theme, wallpapers, chat history"
    },
    "5": {
      "icon": Icons.notifications_none_rounded,
      "text": "Notifications",
      "subtext": "Message, group & call tones"
    },
    "6": {
      "icon": Icons.data_saver_off_rounded,
      "text": "Storage and data",
      "subtext": "Network usage, auto-download"
    },
    "7": {
      "icon": Icons.language_rounded,
      "text": "App language",
      "subtext": "English (device's language)"
    },
    "8": {
      "icon": Icons.help_outline_rounded,
      "text": "Help",
      "subtext": "Help center, contact us, privacy policy"
    },
    "9": {
      "icon": Icons.people_alt_outlined,
      "text": "Invite a friend",
      "subtext": ""
    },
    "10": {
      "icon": Icons.mobile_friendly_rounded,
      "text": "App Updates",
      "subtext": ""
    },
  };
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isbio) {
          setState(() {
            isbio = !isbio;
          });
        } else {
          Navigator.pop(context);
        }

        return false;
      },
      child: Scaffold(
        backgroundColor: Variables.lightBlack,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Variables.lightBlack,
                  width: double.infinity,
                  height: 87,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 10.0, right: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (isbio) {
                                  setState(() {
                                    isbio = !isbio;
                                  });
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 25,
                                color: Variables.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                isbio ? "Profile" : "Settings",
                                style: TextStyle(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.w500,
                                    color: Variables.white),
                              ),
                            ),
                            !isbio
                                ? Icon(
                                    Icons.search,
                                    color: Variables.white,
                                    size: 25,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Divider(
                        height: 0.0,
                        color: Variables.lightGrey.withOpacity(0.1),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: !isbio ? buildSettings() : buildProfile(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildProfile(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
              height: MediaQuery.of(context).size.width * 0.42,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              "Edit",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30.0,
            ),
            buildItems(Icons.person_outline_rounded, "Name", "Mahi💫"),
            buildItems(Icons.info_outline, "About", "Focus on yourself ✨"),
            buildItems(Icons.call_outlined, "Phone", "+91 1234567890"),
            buildItems(Icons.link, "Links", "Add links")
          ],
        ),
        Positioned(
          top: isbio ? 30 : 107,
          left: isbio
              ? (MediaQuery.of(context).size.width -
                      (isbio
                          ? MediaQuery.of(context).size.width * 0.42
                          : 48)) /
                  2
              : 15,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isbio = !isbio;
              });
            },
            child: AnimatedContainer(
              width: isbio ? MediaQuery.of(context).size.width * 0.42 : 60,
              height: isbio ? MediaQuery.of(context).size.width * 0.42 : 60,
              duration: const Duration(microseconds: 5000),
              curve: Curves.ease,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Variables.lightGrey,
                border: Border.all(width: 1.0, color: Variables.lightGrey),
                image: const DecorationImage(
                    image: AssetImage('assets/images/Mahi.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildSettings() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 25.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isbio = !isbio;
                    });
                  },
                  child: Container(
                    width: 58,
                    height: 58,
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
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mahi💫",
                        style: TextStyle(
                            color: Variables.white,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Focus on yourself ✨",
                        style: TextStyle(
                          color: Variables.lightGrey.withOpacity(0.7),
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.qr_code_outlined,
                  color: Colors.green,
                  size: 23,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Icon(
                  Icons.add_circle_outline_outlined,
                  color: Colors.green,
                  size: 23,
                ),
              ],
            ),
          ),
          Divider(
            height: 0.0,
            color: Variables.lightGrey.withOpacity(0.1),
          ),
          ListView.builder(
            itemCount: 11,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildItems(
                  data[index.toString()]["icon"],
                  data[index.toString()]["text"],
                  data[index.toString()]["subtext"]);
            },
          ),
        ],
      ),
    );
  }

  buildItems(IconData data, String title, String subText) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ThemePage()));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 14.0),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.18,
              height: 40,
              child: Icon(
                data,
                size: 24,
                color: Variables.lightGrey.withOpacity(0.8),
              ),
            ),
            const SizedBox(
              width: 3.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Variables.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                  subText != ""
                      ? Text(
                          subText,
                          style: TextStyle(
                            color: subText == "Add links"
                                ? Colors.green
                                : Variables.lightGrey.withOpacity(0.7),
                            fontSize: 13.0,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
