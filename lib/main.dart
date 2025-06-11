import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/screens/splash.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        systemNavigationBarColor: Color.fromARGB(255, 13, 18, 22),
        statusBarColor: Color.fromARGB(255, 13, 18, 22),
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final bool isDark = themeController.isDarkMode.value;
    // Set status bar and nav bar color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent for immersive UI
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark ? Colors.black : Colors.white,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );
    return MaterialApp(
      title: 'Whatsapp',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        colorScheme: ColorScheme.light(
            primary: Colors.white,
            secondary: const Color.fromARGB(255, 214, 214, 214),
            secondaryContainer: const Color.fromARGB(102, 159, 242, 162),
            surfaceContainer:
                const Color.fromARGB(255, 236, 236, 236), // chat info
            surfaceContainerLow: Colors.grey.shade400.withOpacity(0.1), //
            surfaceContainerLowest:
                Colors.grey.withOpacity(0.7), // Border color
            onPrimary: Colors.black87, // text color
            onSecondary:
                Colors.black38.withOpacity(0.6), // secondray text color
            onSecondaryContainer: const Color.fromARGB(255, 128, 219, 131),
            tertiaryContainer: Colors.white, // chat msg container color
            onTertiaryContainer: Colors.grey.shade100),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        colorScheme: ColorScheme.dark(
          primary: const Color.fromARGB(255, 13, 18, 22),
          secondary: const Color.fromARGB(255, 40, 40, 40),
          secondaryContainer: const Color.fromRGBO(76, 175, 80, 0.4),
          surfaceContainer: Colors.black, // chat info
          surfaceContainerLow: Colors.grey.shade400.withOpacity(0.1), //
          surfaceContainerLowest: Colors.white.withOpacity(0.2), // Border color
          onPrimary: Colors.white, // text color
          onSecondary:
              Colors.grey.shade400.withOpacity(0.8), // secondray text color
          onSecondaryContainer: const Color.fromARGB(255, 185, 244, 187),
          tertiaryContainer: const Color.fromARGB(255, 59, 74, 82),
          onTertiaryContainer: Colors.grey.withOpacity(0.1),
        ),
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  // Toggle the theme and save the state
  void toggleTheme(bool isDark) async {
    isDarkMode.value = isDark;
    // Get.changeTheme(isDark ? darkThemeGrey : darkThemeGrey);
    Get.forceAppUpdate();
    _saveTheme(isDark); // Save the selected theme in local storage
  }

  // Save the theme preference
  void _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // Load the saved theme preference
  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    // Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
  }
}
