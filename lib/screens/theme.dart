import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/main.dart';
import 'package:whatsapp/widgets/variables.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  final ThemeController themeController = Get.find<ThemeController>();
  String theme = "Dark";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            width: double.infinity,
            height: 87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
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
                          // color: Variables.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "Chats",
                          style: TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Divider(
                  height: 0.0,
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 10.0, bottom: 10.0),
                        child: Text(
                          'Display',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      popUpMenu();
                    },
                    child: buildItems(
                        Icons.color_lens_outlined, "Theme",themeController.isDarkMode.value?"Dark": "Light", false),
                  ),
                  buildItems(Icons.color_lens_outlined, "Default chat theme",
                      "", false),
                  Divider(
                    height: 0.0,
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 13.0, bottom: 10.0),
                        child: Text(
                          'Chat settings',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  buildItems(null, "Enter is send",
                      "Enter key will send your message", true),
                  buildItems(
                      null,
                      "Media visbility",
                      "Show newly downloaded media in your device's gallery",
                      true),
                  buildItems(null, "Font size", "Medium", false),
                  buildItems(null, "Voice message transcripts",
                      "Read new voice messagesa", true),
                  Divider(
                    height: 0.0,
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 13.0, bottom: 10.0),
                        child: Text(
                          'Archived chats',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  buildItems(
                      null,
                      "Keep chats archived",
                      "Archived chats will remain archived when you receive a new message",
                      true),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    height: 0.0,
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  buildItems(
                      Icons.cloud_upload_outlined, "Chat backup", "", false),
                  buildItems(Icons.send_to_mobile_outlined, "Transfer chats",
                      "", false),
                  buildItems(Icons.history, "Chat history", "", false),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildItems(IconData? data, String title, String subText, bool isSwitch) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 14.0),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.18,
            height: 40,
            child: isSwitch
                ? null
                : Icon(
                    data,
                    size: 24,
                    color: Theme.of(context).colorScheme.onSecondary,
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
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
                subText != ""
                    ? Text(
                        subText,
                        style: TextStyle(
                          color: subText == "Add links"
                              ? Colors.green
                              : Theme.of(context).colorScheme.onSecondary,
                          fontSize: 13.0,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          isSwitch
              ? Switch(
                  value: true,
                  inactiveThumbColor: Variables.lightGrey,
                  focusColor: Colors.black,
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: Variables.lightBlack,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) {
                    isSwitch = !isSwitch;
                  },
                )
              : const SizedBox(),
          const SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }

  void popUpMenu() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose theme',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onPrimary
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Radio(
                            value: "System default",
                            groupValue: theme,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                theme = value!;
                              });
                            }),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'System default',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                              color: Theme.of(context).colorScheme.onPrimary
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Radio(
                            value: "Light",
                            groupValue: theme,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                theme = value!;
                              });
                            }),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Light',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                              color: Theme.of(context).colorScheme.onPrimary
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Radio(
                            value: "Dark",
                            groupValue: theme,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                theme = value!;
                              });
                            }),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Dark',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                              color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (theme == "Dark") {
                              themeController.toggleTheme(true);
                            } else if (theme == "Light") {
                              themeController.toggleTheme(false);
                            } else {
                              themeController.toggleTheme(true);
                            }
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Ok',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
