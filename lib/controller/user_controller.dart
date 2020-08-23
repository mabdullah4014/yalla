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

  void exists(UserExistRequest userExistRequest,
      {Function(bool) onUserExits}) async {
    repository.exists(userExistRequest).then((value) {
      if (value != null) {
        onUserExits(value.data);
      } else
        onUserExits(false);
    });
  }

  void update({Function(User) onUpdateUser}) async {
    loginFormKey.currentState.save();
    repository.update(user).then((value) {
      if (value.status == 200) setCurrentUser(value);
      onUpdateUser(value);
    });
  }

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
