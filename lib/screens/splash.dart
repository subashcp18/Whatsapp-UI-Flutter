import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:whatsapp/screens/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/wlogogreen.png',
              width: MediaQuery.of(context).size.width * 0.25,
            ),
          ),
          Positioned(
              bottom: 50,
              left: MediaQuery.of(context).size.width * 0.33,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/meta.png',
                    width: 60,
                  ),
                  const Text(
                    'Meta',
                    style: TextStyle(
                        color: Color.fromARGB(255, 97, 97, 97),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
