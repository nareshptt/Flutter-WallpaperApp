import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaperapp/Pages/BottumNavigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Route route = MaterialPageRoute(builder: (context) => BottumNavigation());
      Navigator.pushReplacement(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 84, 87, 93),
        child: Center(
            child: Text(
          "Amigo",
          style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: "Poppins"),
        )),
      ),
    );
  }
}
