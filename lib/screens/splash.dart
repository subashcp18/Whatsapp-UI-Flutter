import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:whatsapp/screens/home.dart';
import 'package:whatsapp/widgets/variables.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.lightBlack.withOpacity(0.8),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/wlogogreen.png',
              width: MediaQuery.of(context).size.width * 0.23,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 82,
            left: MediaQuery.of(context).size.width * 0.44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    'from',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width * 0.37,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/meta.png',
                  width: 24,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: const Text(
                    'Meta',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
