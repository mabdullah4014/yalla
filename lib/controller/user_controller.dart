import 'dart:convert';
import 'dart:io';

import 'package:arbi/model/user.dart';
import 'package:arbi/utils/pref_util.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:package_info/package_info.dart';

import '../repo/user_repository.dart' as repository;

ValueNotifier<User> currentUser = new ValueNotifier(User());

class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;

//  FirebaseMessaging _firebaseMessaging;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    PackageInfo.fromPlatform().then((value) {
      user.app_version = value.version;
      if (Platform.isIOS)
        user.device = 'ios';
      else
        user.device = 'android';
    });
//    _firebaseMessaging = FirebaseMessaging();
//    _firebaseMessaging.getToken().then((String _deviceToken) {
//      user.deviceToken = _deviceToken;
//    });
  }

  void login({Function(User) onUserLogin}) async {
    loginFormKey.currentState.save();
    repository.login(user).then((value) {
      if (value.status == 200) setCurrentUser(value);
      onUserLogin(value);
    });
  }

  void register({Function(User) onUserRegister}) async {
    loginFormKey.currentState.save();
    repository.register(user).then((value) {
      onUserRegister(value);
    });
  }

  void update({Function(User) onUpdateUser}) async {
    loginFormKey.currentState.save();
    repository.update(user).then((value) {
      onUpdateUser(value);
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

  void setCurrentUser(User userData) {
    if (userData != null) {
      userData.auth = true;
      PreferenceUtils.setString('current_user', json.encode(userData));
      currentUser.value = userData;
      print('Yalla user ${userData.toString()}');
    }
  }

  static Future<User> getCurrentUser() async {
    String prefUser = PreferenceUtils.getString('current_user');
    if (currentUser.value.auth == null && prefUser.isNotEmpty) {
      currentUser.value = User.fromJSON(json.decode(prefUser));
      currentUser.value.auth = true;
    } else {
      currentUser.value.auth = false;
    }
    currentUser.notifyListeners();
    return currentUser.value;
  }
}
