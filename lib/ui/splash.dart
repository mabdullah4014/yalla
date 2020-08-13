import 'dart:async';

import 'package:arbi/controller/splash_controller.dart';
import 'package:arbi/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends StateMVC<SplashScreen> {
  SplashController _con;
  String domainName;

  SplashScreenState() : super(SplashController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: SplashController.splashScreenDuration), () {
//      bool walkThrough =
//          PreferenceUtils.getBool(PreferenceUtils.pref_walk_through);
//      if (!walkThrough) {
//        Navigator.of(context).pushReplacementNamed("/Walkthrough");
//      } else {
      Constants.proceedToMainPage(context);
//      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        body: SafeArea(
            child: Container(
                child: Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
              Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50),
              CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).accentColor))
            ])))));
  }
}
