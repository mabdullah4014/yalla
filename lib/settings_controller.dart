import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'repo/settings_repository.dart' as settingRepo;

class SettingsController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  SettingsController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    settingRepo.initSettings().then((setting) {
      setState(() {
        settingRepo.setting.value = setting;
      });
    });
  }
}
