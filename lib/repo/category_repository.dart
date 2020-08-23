import 'dart:convert';
import 'dart:io';

import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/check_service_request.dart';
import 'package:arbi/model/check_service_response.dart';
import 'package:arbi/model/place_order_request.dart';
import 'package:arbi/model/place_order_response.dart';
import 'package:arbi/model/provider_categories_response.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../controller/user_controller.dart' as userCont;

Future<CatResponse> getCategories() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}services';
  final client = new http.Client();
  final response = await client.get(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer ${userCont.currentUser.value.auth_token}'
    },
  );
  CatResponse catResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('code') && jsonResponse['code'] == 200) {
      catResponse = CatResponse.fromJson(json.decode(response.body));
    } else {
      catResponse = CatResponse.status(CatResponse.STATUS_INVALID);
    }
  } else {
    catResponse = CatResponse.status(CatResponse.STATUS_SOMETHING_WENT_WRONG);
  }
  return catResponse;
}

Future<Stream<ServiceValue>> getCategoriesDump() async {
  String jsonString = await _loadFromAsset();
  final jsonResponse = jsonDecode(jsonString);
  CatResponse categoryResponse = CatResponse.fromJson(jsonResponse);
  return Stream.fromIterable(categoryResponse.data.values);
}

Future<String> _loadFromAsset() async {
  return await rootBundle.loadString("assets/cfg/categories.json");
}

Future<CheckServiceResponse> getServicePrice(
    CheckServiceRequest checkServiceRequest) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}check';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer ${userCont.currentUser.value.auth_token}'
    },
    body: json.encode(checkServiceRequest.toJson()),
  );
  CheckServiceResponse checkServiceResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') &&
        jsonResponse['status_code'] == 200) {
      checkServiceResponse =
          CheckServiceResponse.fromJson(json.decode(response.body));
    } else {
      checkServiceResponse =
          CheckServiceResponse.status(CheckServiceResponse.STATUS_INVALID);
    }
  } else {
    checkServiceResponse = CheckServiceResponse.status(
        CheckServiceResponse.STATUS_SOMETHING_WENT_WRONG);
  }
  return checkServiceResponse;
}

Future<PlaceOrderResponse> servicePlaceOrder(
    PlaceOrderRequest placeOrderRequest) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}order';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer ${userCont.currentUser.value.auth_token}'
    },
    body: json.encode(placeOrderRequest.toJson()),
  );
  PlaceOrderResponse placeOrderResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') &&
        jsonResponse['status_code'] == 200) {
      placeOrderResponse =
          PlaceOrderResponse.fromJson(json.decode(response.body));
    } else {
      placeOrderResponse =
          PlaceOrderResponse.status(PlaceOrderResponse.STATUS_INVALID);
    }
  } else {
    placeOrderResponse = PlaceOrderResponse.status(
        CheckServiceResponse.STATUS_SOMETHING_WENT_WRONG);
  }
  return placeOrderResponse;
}

Future<ProviderCategoriesResponse> getProviderCat() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}providersService';
  final client = new http.Client();
  final response = await client.get(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer ${userCont.currentUser.value.auth_token}'
    },
  );
  ProviderCategoriesResponse catResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('code') && jsonResponse['code'] == 200) {
      catResponse =
          ProviderCategoriesResponse.fromJson(json.decode(response.body));
    } else {
      catResponse = ProviderCategoriesResponse.status(
          ProviderCategoriesResponse.STATUS_INVALID);
    }
  } else {
    catResponse = ProviderCategoriesResponse.status(
        ProviderCategoriesResponse.STATUS_SOMETHING_WENT_WRONG);
  }
  return catResponse;
}
