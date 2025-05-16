import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
