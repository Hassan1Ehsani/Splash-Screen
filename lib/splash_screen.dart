import 'dart:async';
import 'package:flutter/material.dart';
import 'package:splash_screen/authentication_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimer() {
    Timer(Duration(seconds: 2), () {
      Route newRoute =
          MaterialPageRoute(builder: (context) => AuthenticationScreen());
      Navigator.pushReplacement(context, newRoute);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/intro.png"),
              SizedBox(
                height: 30,
              ),
              Text(
                "Hello Flutter",
                style: TextStyle(fontSize: 60, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
