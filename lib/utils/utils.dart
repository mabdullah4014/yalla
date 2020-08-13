import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static Color getColorFromHash(String color) {
    try {
      return Color(int.parse(color.replaceAll("#", "0xFF")));
    } catch (e) {
      return Color(0xFFCCCCCC) /*.withOpacity(opacity)*/;
    }
  }

  static Future<String> loadJsonFromAssets(BuildContext context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    return json.decode(data);
  }

  static var random = new Random();

  static Color getRandomColor() {
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  static Widget submitButton(
      BuildContext context, String text, VoidCallback onPress) {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 10),
            onPressed: onPress,
            color: Theme.of(context).primaryColor,
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: Colors.white),
            )));
  }
}
