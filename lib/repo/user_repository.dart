import 'dart:convert';
import 'dart:io';

import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/model/user.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<User> login(User user) async {
  print('Login Request : ${user.toString()}');
  final String url = '${GlobalConfiguration().getString('api_base_url')}login';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toJson()),
  );
  User cUser;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('success') && jsonResponse['success'] == 200) {
      cUser = User.fromJSON(json.decode(response.body)['data']);
    } else {
      cUser = User.status(User.STATUS_INVALID);
    }
  } else {
    cUser = User.status(User.STATUS_SOMETHING_WENT_WRONG);
  }
  return cUser;
}

Future<User> register(User user) async {
  print('Register Request : ${user.toString()}');
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}register';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toJson()),
  );
  User currentUser;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('success') && jsonResponse['success'] == 200) {
      currentUser = User.fromJSON(json.decode(response.body)['data']);
    } else {
      currentUser = User.status(User.STATUS_INVALID);
    }
  } else {
    currentUser = User.status(User.STATUS_SOMETHING_WENT_WRONG);
  }
  return currentUser;
}

Future<User> update(User updatedUser) async {
  print('Update Request : ${updatedUser.toString()}');
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}users/updateUser/${updatedUser.id}';
  final client = new http.Client();

  Map<String, String> headers = Map();
  headers[HttpHeaders.contentTypeHeader] = 'application/json';
  if (currentUser.value != null && currentUser.value.hasAuthToken())
    headers[HttpHeaders.authorizationHeader] =
        'Bearer ${currentUser.value.auth_token}';
  final response = await client.post(
    url,
    headers: headers,
    body: json.encode(updatedUser.toJson()),
  );
  User cUser;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('success') && jsonResponse['success'] == 200) {
      cUser = User.fromJSON(json.decode(response.body)['data']);
    } else {
      cUser = User.status(User.STATUS_INVALID);
    }
  } else {
    cUser = User.status(User.STATUS_SOMETHING_WENT_WRONG);
  }
  return cUser;
}

Future<bool> resetPassword(User user) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}send_reset_link_email';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.auth_token}'
    },
    body: json.encode(user.toJson()),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body)['data']);
    return true;
  } else {
    return false;
  }
}

//Future<void> logout() async {
//  currentUser.value = new User();
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  await prefs.remove('current_user');
//}

//Future<User> update(User user) async {
//  final String _apiToken = 'api_token=${currentUser.value.authToken}';
//  final String url =
//      '${GlobalConfiguration().getString('api_base_url')}users/${currentUser.value.id}?$_apiToken';
//  final client = new http.Client();
//  final response = await client.post(
//    url,
//    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//    body: json.encode(user.toMap()),
//  );
//  setCurrentUser(response.body);
//  currentUser.value = User.fromJSON(json.decode(response.body)['data']);
//  return currentUser.value;
//}
