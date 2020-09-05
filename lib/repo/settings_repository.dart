import 'dart:convert';
import 'dart:io';

import 'package:arbi/model/language.dart';
import 'package:arbi/model/setting.dart';
import 'package:arbi/utils/constants.dart';
import 'package:arbi/utils/pref_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());

Future<Setting> initSettings() async {
  Setting _setting;
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}configurations';
  final response = await http.get(url, headers: Constants.getHeader());
  if (response.statusCode == 200 &&
      response.headers.containsValue('application/json')) {
    if (json.decode(response.body)['data'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'settings', json.encode(json.decode(response.body)['data']));
      _setting = Setting.fromJSON(json.decode(response.body)['data']);
      setting.value = _setting;
      setting.notifyListeners();
    }
  }
  print("initSettings");
  return setting.value;
}

void setBrightness(Brightness brightness) async {
  brightness == Brightness.dark
      ? PreferenceUtils.setBool("isDark", true)
      : PreferenceUtils.setBool("isDark", false);
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    PreferenceUtils.setString('language', language);
  }
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  return PreferenceUtils.getString('language', defaultLanguage);
}
