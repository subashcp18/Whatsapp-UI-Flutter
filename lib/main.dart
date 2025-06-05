import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          surfaceContainer: const Color.fromARGB(255, 236, 236, 236), // chat info
          surfaceContainerLow: Colors.grey.shade400.withOpacity(0.1), //
          surfaceContainerLowest: Colors.grey.withOpacity(0.7), // Border color
          onPrimary: Colors.black87, // text color
          onSecondary:
              Colors.black38.withOpacity(0.6), // secondray text color
          // onSecondaryFixed: ,
          onSecondaryContainer: const Color.fromARGB(255, 128, 219, 131),
        ),
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
          surfaceContainer: Colors.black,  // chat info
          surfaceContainerLow: Colors.grey.shade400.withOpacity(0.1), //
          surfaceContainerLowest: Colors.white.withOpacity(0.2), // Border color
          onPrimary: Colors.white,   // text color
          onSecondary: Colors.grey.shade400.withOpacity(0.8), // secondray text color
          // onSecondaryFixed: ,
          onSecondaryContainer: const Color.fromARGB(255, 185, 244, 187),
        ),
      ),
      themeMode: isDark? ThemeMode.dark: ThemeMode.light,
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
    Get.changeTheme(isDark ? darkThemeGrey : darkThemeGrey);
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
    Get.changeTheme(isDarkMode.value ? darkThemeGrey : darkThemeGrey);
  }

  ThemeData darkThemeGrey = ThemeData(
    brightness: Brightness.dark, // Use Brightness.dark
    primaryColor: const Color.fromARGB(255, 13, 18, 22),
    scaffoldBackgroundColor: const Color.fromARGB(255, 13, 18, 22),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 13, 18, 22),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey[700], // Button color
      textTheme: ButtonTextTheme.primary, // Text color in buttons
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white60),
      titleLarge: TextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.dark(
      primary: const Color.fromARGB(255, 13, 18, 22), // Primary color for widgets
      secondary: Colors.blueGrey[200]!, // Secondary color for accents
      surface: Colors.grey[800]!, // Surface color for containers, etc.
      background: Colors.grey[850]!, // Background color for screens
      onPrimary: Colors.white, // Text color on primary elements
      onSurface: Colors.white, // Text color on surface elements
      onSecondary: Colors.white, // Text color on secondary elements
    ).copyWith(background: const Color.fromARGB(255, 13, 18, 22)),
  );
}
