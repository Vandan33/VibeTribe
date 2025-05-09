import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vibe_tribe/home.dart';
import 'package:vibe_tribe/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3),()
    {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => login()),);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Stack(
            children: [
              Image.asset("assets/logo.png",height: 310,width: 310,),
              Positioned(child:Container(
                margin: EdgeInsets.only(left: 108,top: 54),
                child: Lottie.asset(
                  "assets/flight2.json",
                  height: 95,
                  width: 95,
                ),
              )),
            ],
          ),
        ),
      )
    );
  }
}

/*class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3),()
    {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => home()),);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Stack(
            children: [
              Image.asset("assets/logo.png",height: 310,width: 310,),
              Positioned(child:Container(
                margin: EdgeInsets.only(left: 108,top: 54),
                child: Lottie.asset(
                  "assets/flight2.json",
                  height: 95,
                  width: 95,
                ),
              )),
            ],
          ),
        ),
      )
    );
  }
}*/