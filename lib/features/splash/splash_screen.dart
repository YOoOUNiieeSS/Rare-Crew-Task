import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rare_crew_test/shared_resources/routes_manager.dart';
import 'package:rare_crew_test/shared_resources/string_manager.dart';
import 'package:rare_crew_test/shared_resources/styles_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_resources/color_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2, milliseconds: 500), _navigate);
  }

  _navigate() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getBool(StringManager.isLoggedKey)??false){
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    }
    else{
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.appBarDark,
        body: SafeArea(
          child: Center(
            child: Text(
              StringManager.welcome,
              style: getBoldStyle(
                color: ColorManager.primaryTextDark,
                fontSize: 16,
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
