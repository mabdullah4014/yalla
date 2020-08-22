import 'dart:async';

import 'package:arbi/controller/splash_controller.dart';
import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/model/user.dart';
import 'package:arbi/route_generator.dart';
import 'package:arbi/utils/utils.dart';
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
      UserController.getCurrentUser().then((value) {
        if (value.auth) {
          if (value.user_type == User.CUSTOMER) {
            Navigator.of(context).popAndPushNamed(RouteGenerator.MAIN);
          } else if (value.user_type == User.SERVICE_PROVIDER) {
            Navigator.of(context).popAndPushNamed(RouteGenerator.PROFILE_PROVIDER);
          }
        } else {
          Navigator.of(context).popAndPushNamed(RouteGenerator.MAIN);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _con.scaffoldKey,
        body: SafeArea(
            child: Stack(children: [
          Container(
              color: AppUtils.getColorFromHash('#1196A7'),
              height: height,
              width: width),
          Center(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Image.asset('assets/images/logo_square.png', fit: BoxFit.cover),
                SizedBox(height: 50),
                CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor))
              ]))
        ])));
  }
}
