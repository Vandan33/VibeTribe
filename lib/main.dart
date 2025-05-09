import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_tribe/splash_screen.dart';
import 'package:vibe_tribe/wishlist_provider.dart';



void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:SplashScreen(),
    );
  }
}