import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/user.dart';
import 'package:arbi/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repo/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;

//  FirebaseMessaging _firebaseMessaging;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
//    _firebaseMessaging = FirebaseMessaging();
//    _firebaseMessaging.getToken().then((String _deviceToken) {
//      user.deviceToken = _deviceToken;
//    });
  }

  void login() async {
    loginFormKey.currentState.save();
    Navigator.of(context).popAndPushNamed(RouteGenerator.MAIN);
//      repository.login(user).then((value) {
//        if (value != null && value.apiToken != null) {
//          scaffoldKey.currentState.showSnackBar(
//              SnackBar(content: Text(S.of(context).welcome + value.name)));
//          Navigator.of(scaffoldKey.currentContext)
//              .pushReplacementNamed(RouteGenerator.MAIN);
//        } else {
//          scaffoldKey.currentState.showSnackBar(
//              SnackBar(content: Text(S.current.wrong_email_or_password)));
//        }
//      });
  }

  void register() async {
    loginFormKey.currentState.save();
    repository.register(user).then((value) {
      if (value != null && value.apiToken != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(S.of(context).welcome + value.name),
        ));
        Navigator.of(scaffoldKey.currentContext)
            .pushReplacementNamed('/Pages', arguments: 2);
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(S.of(context).wrong_email_or_password),
        ));
      }
    });
  }

/*void resetPassword() {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.resetPassword(user).then((value) {
        if (value != null && value == true) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(S.current.your_reset_link_has_been_sent_to_your_email),
            action: SnackBarAction(
              label: S.current.login,
              onPressed: () {
                Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Login');
              },
            ),
            duration: Duration(seconds: 10),
          ));
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(S.current.error_verify_email_settings),
          ));
        }
      });
    }
  }*/
}
