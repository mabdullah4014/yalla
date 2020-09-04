import 'dart:convert';

import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/check_service_request.dart';
import 'package:arbi/model/check_service_response.dart';
import 'package:arbi/model/customer_order_response.dart';
import 'package:arbi/model/place_order_request.dart';
import 'package:arbi/model/place_order_response.dart';
import 'package:arbi/model/provider_categories_response.dart';
import 'package:arbi/model/update_job_request.dart';
import 'package:arbi/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<CatResponse> getCategories() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}services';
  final client = new http.Client();
  final response = await client.get(url, headers: Constants.getHeader());
  print('Get Services Response : ${response.body}');
  CatResponse catResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('code') && jsonResponse['code'] == 200) {
      catResponse = CatResponse.fromJson(json.decode(response.body));
    } else {
      catResponse = CatResponse.status(Constants.STATUS_INVALID);
    }
  } else {
    catResponse = CatResponse.status(Constants.STATUS_SOMETHING_WENT_WRONG);
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
  Map<String, String> mapB = Map.from(checkServiceRequest.target);
  print('Get Service price  Request : ${checkServiceRequest.toString()}');
  final String url = '${GlobalConfiguration().getString('api_base_url')}check';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: Constants.getHeader(),
    body: json.encode(checkServiceRequest.toJson()),
  );
  print('Calculate Response : ${response.body}');
  CheckServiceResponse checkServiceResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') &&
        jsonResponse['status_code'] == 200) {
      checkServiceResponse =
          CheckServiceResponse.fromJson(json.decode(response.body));
    } else {
      checkServiceResponse =
          CheckServiceResponse.status(Constants.STATUS_INVALID);
    }
  } else {
    checkServiceResponse =
        CheckServiceResponse.status(Constants.STATUS_SOMETHING_WENT_WRONG);
  }
  checkServiceResponse.target = mapB;
  return checkServiceResponse;
}

Future<PlaceOrderResponse> servicePlaceOrder(
    PlaceOrderRequest placeOrderRequest) async {
  print('Palce order  Request : ${placeOrderRequest.toString()}');
  final String url = '${GlobalConfiguration().getString('api_base_url')}order';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: Constants.getHeader(),
    body: json.encode(placeOrderRequest.toJson()),
  );
  print('Place Order Response : ${response.body}');
  PlaceOrderResponse placeOrderResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') &&
        jsonResponse['status_code'] == 200) {
      placeOrderResponse =
          PlaceOrderResponse.fromJson(json.decode(response.body));
    } else {
      placeOrderResponse = PlaceOrderResponse.status(Constants.STATUS_INVALID);
    }
  } else {
    placeOrderResponse =
        PlaceOrderResponse.status(Constants.STATUS_SOMETHING_WENT_WRONG);
  }
  return placeOrderResponse;
}

Future<ProviderCategoriesResponse> getProviderCat() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}providersService';
  final client = new http.Client();
  final response = await client.get(url, headers: Constants.getHeader());
  print('Provider Categories Response : ${response.body}');
  ProviderCategoriesResponse catResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('code') && jsonResponse['code'] == 200) {
      catResponse =
          ProviderCategoriesResponse.fromJson(json.decode(response.body));
    } else {
      catResponse = ProviderCategoriesResponse.status(Constants.STATUS_INVALID);
    }
  } else {
    catResponse = ProviderCategoriesResponse.status(
        Constants.STATUS_SOMETHING_WENT_WRONG);
  }
  return catResponse;
}

Future<CustomerOrderResponse> getCustomerOrders() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}customerOrders';
  final client = new http.Client();
  final response = await client.post(url, headers: Constants.getHeader());
  print('Customer Order Response : ${response.body}');
  CustomerOrderResponse customerOrderResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') &&
        jsonResponse['status_code'] == 200) {
      customerOrderResponse =
          CustomerOrderResponse.fromJson(json.decode(response.body));
    } else {
      customerOrderResponse =
          CustomerOrderResponse.status(Constants.STATUS_INVALID);
    }
  } else {
    customerOrderResponse =
        CustomerOrderResponse.status(Constants.STATUS_SOMETHING_WENT_WRONG);
  }
  return customerOrderResponse;
}

Future<CustomerOrderResponse> getProviderJobs() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}serviceProviderOrders';
  final client = new http.Client();
  final response = await client.post(url, headers: Constants.getHeader());
  print('Provider Jobs Response : ${response.body}');
  CustomerOrderResponse customerOrderResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') &&
        jsonResponse['status_code'] == 200) {
      customerOrderResponse =
          CustomerOrderResponse.fromJson(json.decode(response.body));
    } else {
      customerOrderResponse =
          CustomerOrderResponse.status(Constants.STATUS_INVALID);
    }
  } else {
    customerOrderResponse =
        CustomerOrderResponse.status(Constants.STATUS_SOMETHING_WENT_WRONG);
  }
  return customerOrderResponse;
}

Future<bool> updateProviderJob(UpdateJobRequest request) async {
  print('Update job  Request : ${request.toString()}');
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}updateOrder';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: Constants.getHeader(),
    body: json.encode(request.toJson()),
  );
  print('Update Provider job Response : ${response.body}');
  bool orderUpdated;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') &&
        jsonResponse['status_code'] == 200) {
      orderUpdated = true;
    } else {
      orderUpdated = false;
    }
  } else {
    orderUpdated = false;
  }
  return orderUpdated;
}

Future<CustomerOrderResponse> getProviderPendingJobs() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}providerPendingOrders';
  final client = new http.Client();
  final response = await client.get(url, headers: Constants.getHeader());
  print('Provider pending job Response : ${response.body}');
  CustomerOrderResponse customerOrderResponse;
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('status_code') &&
        jsonResponse['status_code'] == 200) {
      customerOrderResponse =
          CustomerOrderResponse.fromJson(json.decode(response.body));
    } else {
      customerOrderResponse =
          CustomerOrderResponse.status(Constants.STATUS_INVALID);
    }
  } else {
    customerOrderResponse =
        CustomerOrderResponse.status(Constants.STATUS_SOMETHING_WENT_WRONG);
  }
  return customerOrderResponse;
}
