import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/loginscreen.dart';
import 'bottom_navigationbar.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  @override

  //it will call itself and startTimer method
  void initState() {
    super.initState();
    startTimer();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  //method to count splash screen time for 3 sec
  startTimer() async {
    var duration = const Duration(seconds: 3);
    var currentUser = auth.currentUser;
    //condition to see if the user already lodged in or not
    if (currentUser != null) {
      return new Timer(duration, homeRoute);
    } else {
      return new Timer(duration, loginRoute);
    }
  }

  //navigate to login page method
  loginRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  //navigate to push at bottom Navigation Bar
  homeRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => BottomNavBar()));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffF5591F),
                gradient: LinearGradient(
                    colors: [(new Color(0xFF651FFF)), (new Color(0xFF7C4DFF))],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          Center(
            child: Container(
              child: Image.asset("images/logo.jpg"),
            ),
          )
        ],
      ),
    );
  }
}
