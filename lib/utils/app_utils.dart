import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:arbi/generated/l10n.dart';
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

  static void showMessage(BuildContext context, String title, String message,
      {VoidCallback callback}) {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: Colors.black87)),
          content: Text(message, style: TextStyle(color: Colors.red)),
          actions: <Widget>[
            FlatButton(
              child: Text(S.of(context).ok),
              onPressed: () {
                if (callback != null)
                  callback();
                else
                  Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void yesNoDialog(BuildContext context, String title, String message,
      VoidCallback onYesClick) {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: Colors.black87)),
          content: Text(message, style: TextStyle(color: Colors.red)),
          actions: <Widget>[
            FlatButton(
              child: Text(S.of(context).yes),
              onPressed: () {
                onYesClick();
              },
            ),
            FlatButton(
              child: Text(S.of(context).no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static onLoading(BuildContext context, {String message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor)),
                SizedBox(height: 10),
                Text(message != null ? message : S.of(context).loading,
                    style: TextStyle(color: Theme.of(context).primaryColor)),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget cityBg(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Image.asset(
      'assets/images/city_bg.jpg',
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }

  static Widget cityblur() {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
            decoration:
                new BoxDecoration(color: Colors.black.withOpacity(0.5))));
  }
}
