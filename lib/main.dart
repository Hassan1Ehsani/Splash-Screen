import 'package:flutter/material.dart';
import 'package:splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ignore: prefer_const_constructors
      home: SplashScreen(),
    );
  }
}
