import 'dart:convert';
import 'dart:io';

import 'package:arbi/model/user.dart';
import 'package:arbi/model/user_exist_request.dart';
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

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    PackageInfo.fromPlatform().then((value) {
      user.push_notification_token =
          PreferenceUtils.getString(PreferenceUtils.push_token);
      user.app_version = value.version;
      if (Platform.isIOS)
        user.device = 'ios';
      else
        user.device = 'android';
    });
  }

  void login({Function(User) onUserLogin}) async {
    loginFormKey.currentState.save();
    repository.login(user).then((value) {
      if (value.status == 200) {
        value.auth = true;
        setCurrentUser(value);
      }
      onUserLogin(value);
    });
  }

  void register({Function(User) onUserRegister}) async {
    loginFormKey.currentState.save();
    repository.register(user).then((value) {
      if (value.status == 200) {
        value.auth = true;
        setCurrentUser(value);
      }
      onUserRegister(value);
    });
  }

  void exists(UserExistRequest userExistRequest,
      {Function(bool) onUserExits}) async {
    repository.exists(userExistRequest).then((value) {
      if (value != null) {
        onUserExits(value.data);
      } else
        onUserExits(false);
    });
  }

  void update({Function(bool) onUpdateUser}) async {
    loginFormKey.currentState.save();
    repository.update(user).then((value) {
      if (value.status == 200) {
        value.auth = true;
        value.auth_token = currentUser.value.auth_token;
        setCurrentUser(value);
        onUpdateUser(true);
      } else
        onUpdateUser(false);
    });
  }

  static void setCurrentUser(User userData) {
    if (userData != null) {
      PreferenceUtils.setString('current_user', json.encode(userData));
      currentUser.value = userData;
      print('Yalla user ${userData.toString()}');
    }
  }

  static void logout() {
    PreferenceUtils.setString('current_user', "");
  }

  static Future<User> getCurrentUser() async {
    String prefUser = PreferenceUtils.getString('current_user');
    if (prefUser.isNotEmpty) {
      currentUser.value = User.fromJSON(json.decode(prefUser));
    } else {
      currentUser.value.auth = false;
    }
    currentUser.notifyListeners();
    return currentUser.value;
  }
}
