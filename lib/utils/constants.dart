import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../route_generator.dart';

class Constants {

  static const String defaultPhoneCode = '+964';

  static InputDecoration getInputDecoration(
      BuildContext context, String hintText, String labelText,
      {Icon icon}) {
    return new InputDecoration(
        hintText: hintText,
        labelText: labelText,
        icon: icon,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .merge(TextStyle(color: Theme.of(context).focusColor)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).hintColor.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).hintColor)),
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .merge(TextStyle(color: Theme.of(context).hintColor)));
  }

  static void proceedToMainPage(BuildContext context) {
    Navigator.of(context).popAndPushNamed(RouteGenerator.MAIN);
  }
}
