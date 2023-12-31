import 'dart:io';

import 'package:arbi/model/provider_categories_response.dart';
import 'package:arbi/repo/settings_repository.dart';
import 'package:arbi/utils/pref_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';

class User {
  static const String PROVIDER_EMAIL = 'email';
  static const String PROVIDER_FB = 'facebook';

  String id;
  String name;
  String email;
  String password;
  String password_confirmation;
  String auth_token;
  String push_notification_token;
  String phone_no;
  String address;
  String business_bio;
  String business_name;
  String app_version;
  String device;
  String user_type;
  String latitude;
  String longitude;
  int status = 200;
  List<int> provider_categories;
  List<ProviderCategory> categories;
  bool auth = false;
  String provider = PROVIDER_EMAIL;
  String picture_link; //facebook link
  String locale = 'en';
  String profile_pic_path;
  String id_front_path;
  String id_back_path;

  User() {
    this.auth = false;
    PackageInfo.fromPlatform().then((value) {
//      push_notification_token =
//          PreferenceUtils.getString(PreferenceUtils.push_token);
      app_version = value.version;
      if (Platform.isIOS)
        device = 'ios';
      else
        device = 'android';
    });
  }

  User.status(int status) {
    this.status = status;
  }

  User.fromJSON(Map<String, dynamic> jsonMap) {
    email = jsonMap['email'];
    password = jsonMap['password'];
    password_confirmation = jsonMap['password_confirmation'];
    push_notification_token = jsonMap['push_notification_token'];
    app_version = jsonMap['app_version'];
    device = jsonMap['device'];
    name = jsonMap['name'];
    id = jsonMap['id'].toString();
    business_name = jsonMap['business_name'];
    auth_token = jsonMap['auth_token'];
    phone_no = jsonMap['phone_no'];
    address = jsonMap['address'];
    business_bio = jsonMap['business_bio'];
    user_type = jsonMap['user_type'];
    latitude = jsonMap['latitude'];
    longitude = jsonMap['longitude'];
    provider = jsonMap['provider'];
    if (jsonMap["provider_categories"] != null) {
      provider_categories = [];
      jsonMap["provider_categories"].forEach((v) {
        provider_categories.add(v);
      });
    }
    if (jsonMap["categories"] != null) {
      categories = [];
      jsonMap["categories"].forEach((v) {
        categories.add(ProviderCategory.fromJson(v));
      });
    }
    picture_link = jsonMap['picture_link'];
    profile_pic_path = jsonMap['profile_pic_path'];
    id_front_path = jsonMap['id_front_path'];
    id_back_path = jsonMap['id_back_path'];

    locale = jsonMap['locale'];
    setting.value.mobileLanguage.value = Locale(locale ?? 'en');
    setDefaultLanguage(locale ?? 'en');
    setting.notifyListeners();
    auth = true;
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    if (email != null && email.isNotEmpty) map["email"] = email;
    if (password != null && password.isNotEmpty) map["password"] = password;
    if (password_confirmation != null && password_confirmation.isNotEmpty)
      map["password_confirmation"] = password_confirmation;
    if (push_notification_token != null && push_notification_token.isNotEmpty)
      map["push_notification_token"] = push_notification_token;
    if (app_version != null && app_version.isNotEmpty)
      map["app_version"] = app_version;
    if (device != null && device.isNotEmpty) map["device"] = device;
    if (name != null && name.isNotEmpty) map["name"] = name;
    if (id != null && id.isNotEmpty) map["id"] = id;
    if (business_name != null && business_name.isNotEmpty)
      map["business_name"] = business_name;
    if (auth_token != null && auth_token.isNotEmpty)
      map["auth_token"] = auth_token;
    if (phone_no != null && phone_no.isNotEmpty) map["phone_no"] = phone_no;
    if (address != null && address.isNotEmpty) map["address"] = address;
    if (business_bio != null && business_bio.isNotEmpty)
      map["business_bio"] = business_bio;
    if (user_type != null && user_type.isNotEmpty) map["user_type"] = user_type;
    if (latitude != null && latitude.isNotEmpty) map["latitude"] = latitude;
    if (longitude != null && longitude.isNotEmpty) map["longitude"] = longitude;
    if (provider_categories != null && provider_categories.isNotEmpty)
      map["provider_categories"] = provider_categories;
    if (categories != null && categories.isNotEmpty)
      map["categories"] = categories;
    if (provider != null && provider.isNotEmpty) map["provider"] = provider;
    if (picture_link != null && picture_link.isNotEmpty)
      map["picture_link"] = picture_link;
    if (locale != null && locale.isNotEmpty) map["locale"] = locale;
    if (profile_pic_path != null && profile_pic_path.isNotEmpty)
      map["profile_pic_path"] = profile_pic_path;
    if (id_front_path != null && id_front_path.isNotEmpty)
      map["id_front_path"] = id_front_path;
    if (id_back_path != null && id_back_path.isNotEmpty)
      map["id_back_path"] = id_back_path;
    if (auth != null) map["auth"] = auth;
    return map;
  }

  Map<String, dynamic> getMultipartForRegister(Map<String, String> map) {
    if (email != null && email.isNotEmpty) map["email"] = email;
    if (password != null && password.isNotEmpty) map["password"] = password;
    if (password_confirmation != null && password_confirmation.isNotEmpty)
      map["password_confirmation"] = password_confirmation;
    if (push_notification_token != null && push_notification_token.isNotEmpty)
      map["push_notification_token"] = push_notification_token;
    if (app_version != null && app_version.isNotEmpty)
      map["app_version"] = app_version;
    if (device != null && device.isNotEmpty) map["device"] = device;
    if (name != null && name.isNotEmpty) map["name"] = name;
    if (id != null && id.isNotEmpty) map["id"] = id;
    if (business_name != null && business_name.isNotEmpty)
      map["business_name"] = business_name;
    if (auth_token != null && auth_token.isNotEmpty)
      map["auth_token"] = auth_token;
    if (phone_no != null && phone_no.isNotEmpty) map["phone_no"] = phone_no;
    if (address != null && address.isNotEmpty) map["address"] = address;
    if (business_bio != null && business_bio.isNotEmpty)
      map["business_bio"] = business_bio;
    if (user_type != null && user_type.isNotEmpty) map["user_type"] = user_type;
    if (latitude != null && latitude.isNotEmpty) map["latitude"] = latitude;
    if (longitude != null && longitude.isNotEmpty) map["longitude"] = longitude;
    if (picture_link != null && picture_link.isNotEmpty)
      map["picture_link"] = picture_link;
    if (provider != null && provider.isNotEmpty) map["provider"] = provider;
    if (locale != null && locale.isNotEmpty) map["locale"] = locale;
    if (profile_pic_path != null && profile_pic_path.isNotEmpty)
      map["profile_pic_path"] = profile_pic_path;
    if (id_front_path != null && id_front_path.isNotEmpty)
      map["id_front_path"] = id_front_path;
    if (id_back_path != null && id_back_path.isNotEmpty)
      map["id_back_path"] = id_back_path;
    return map;
  }

  @override
  String toString() {
    var map = this.toJson();
    map["auth"] = this.auth;
    return map.toString();
  }

  bool hasAuthToken() {
    return auth_token != null && auth_token.isNotEmpty;
  }

  String location() {
    if (latitude != null &&
        latitude.isNotEmpty &&
        longitude != null &&
        longitude.isNotEmpty) {
      return '$latitude,$longitude';
    }
    return '';
  }

  static const String CUSTOMER = 'customer';
  static const String SERVICE_PROVIDER = 'service_provider';

  User logout() {
    id = null;
    name = null;
    email = null;
    password = null;
    password_confirmation = null;
    auth_token = null;
    push_notification_token = null;
    phone_no = null;
    address = null;
    business_bio = null;
    business_name = null;
    app_version = null;
    device = null;
    user_type = null;
    latitude = null;
    longitude = null;
    provider_categories = null;
    categories = null;
    auth = false;
    provider = null;
    picture_link = null;
    locale = null;
    id_back_path = null;
    id_front_path = null;
    profile_pic_path = null;
    PreferenceUtils.setString('current_user', "");
    return this;
  }
}
