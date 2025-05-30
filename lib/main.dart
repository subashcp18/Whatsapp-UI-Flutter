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
      statusBarBrightness: Brightness.light
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp',
      theme: themeController.isDarkMode.value?
      ThemeData.dark():
      ThemeData.light(),
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
    Get.changeTheme(isDark ? darkThemeGrey : ThemeData.light());
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
    Get.changeTheme(isDarkMode.value ? darkThemeGrey : ThemeData.light());
  }

  ThemeData darkThemeGrey = ThemeData(
    brightness: Brightness.dark, // Use Brightness.dark
    primaryColor: const Color.fromARGB(255, 13, 18, 22),
    scaffoldBackgroundColor: const Color.fromARGB(255, 13, 18, 22),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 13, 18, 22),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey[700], // Button color
      textTheme: ButtonTextTheme.primary, // Text color in buttons
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white60),
      titleLarge: TextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.grey[700]!, // Primary color for widgets
      secondary: Colors.blueGrey[200]!, // Secondary color for accents
      surface: Colors.grey[800]!, // Surface color for containers, etc.
      background: Colors.grey[850], // Background color for screens
      onPrimary: Colors.white, // Text color on primary elements
      onSurface: Colors.white, // Text color on surface elements
      onSecondary: Colors.white, // Text color on secondary elements
    ).copyWith(background: const Color.fromARGB(255, 13, 18, 22)),
  );
}

