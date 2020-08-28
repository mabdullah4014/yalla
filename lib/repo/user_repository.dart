import 'dart:convert';
import 'dart:io';

import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/model/user.dart';
import 'package:arbi/model/user_exist_request.dart';
import 'package:arbi/model/user_exist_response.dart';
import 'package:arbi/utils/constants.dart';
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
  print('Login Response : ${response.body}');
  User cUser;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
      cUser = User.fromJSON(json.decode(response.body)['data']);
    } else {
      cUser = User.status(Constants.STATUS_INVALID);
    }
  } else {
    cUser = User.status(Constants.STATUS_SOMETHING_WENT_WRONG);
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
  print('Register Response : ${response.body}');
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') && jsonResponse['status_code'] == 200) {
      currentUser = User.fromJSON(json.decode(response.body)['data']);
    } else {
      currentUser = User.status(Constants.STATUS_INVALID);
    }
  } else {
    currentUser = User.status(Constants.STATUS_SOMETHING_WENT_WRONG);
  }
  return currentUser;
}

Future<UserExistResponse> exists(UserExistRequest userExistRequest) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}users/exists';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(userExistRequest.toJson()),
  );
  UserExistResponse userExistResponse;
  print('User Exists Response : ${response.body}');
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('success') && jsonResponse['success'] == 200) {
      userExistResponse =
          UserExistResponse.fromJson(json.decode(response.body));
    } else {
      userExistResponse = UserExistResponse.status(Constants.STATUS_INVALID);
    }
  } else {
    userExistResponse =
        UserExistResponse.status(Constants.STATUS_SOMETHING_WENT_WRONG);
  }
  return userExistResponse;
}

Future<User> update(User updatedUser) async {
  print('Update Request : ${updatedUser.toString()}');
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}users/updateUser/${currentUser.value.id}';
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
  print('User update Response : ${response.body}');
  User cUser;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') &&
        jsonResponse['status_code'] == 200) {
      cUser = User.fromJSON(json.decode(response.body)['data']);
    } else {
      cUser = User.status(Constants.STATUS_INVALID);
    }
  } else {
    cUser = User.status(Constants.STATUS_SOMETHING_WENT_WRONG);
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
