import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashController extends ControllerMVC {

  GlobalKey<ScaffoldState> scaffoldKey;
  static final int splashScreenDuration = 3;

  SplashController() {
    scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
