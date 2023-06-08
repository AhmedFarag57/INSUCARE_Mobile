import 'dart:convert';
import 'dart:async';

import 'package:insucare/screens/dashboard/basal_bolus_screen.dart';
import 'package:insucare/screens/onboard/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _setData();
    Timer(
      const Duration(seconds: 3),
      /*
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // ignore: prefer_const_constructors
          builder: (context) => OnboardingScreen(),
        ),
      ),
      */
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // ignore: prefer_const_constructors
          builder: (context) => BasalBolusScreen(),
        ),
      ),
    );
  }

  _setData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var role = {'isUser': 'true'};
    localStorage.setString('role', json.encode(role));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: sized_box_for_whitespace
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Center(
              child: Image.asset(
                'assets/images/logo2.png',
                height: 100,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
