import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/user.dart';
import 'package:flutter/foundation.dart';

/// status_code : "200"
/// orders : [{"id":1,"status":"100","amount":"12500","notes":"pop smoek","latitude":"11.10000000","longitude":"43.60000000","service_provider_id":null,"category_id":24,"user_id":7}]
/// message : ""

class CustomerOrderResponse {
  int status_code;
  List<Order> orders;
  String message;
  int status = 200;

  CustomerOrderResponse.status(int status) {
    this.status = status;
  }

  CustomerOrderResponse({int statusCode, List<Order> orders, String message}) {
    this.status_code = statusCode;
    this.orders = orders;
    this.message = message;
  }

  CustomerOrderResponse.fromJson(dynamic json) {
    status_code = json["status_code"];
    if (json["orders"] != null) {
      orders = [];
      json["orders"].forEach((v) {
        orders.add(Order.fromJson(v));
      });
    }
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = status_code;
    if (orders != null) {
      map["orders"] = orders.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    return map;
  }
}

/// id : 1
/// status : "100"
/// amount : "12500"
/// notes : "pop smoek"
/// latitude : "11.10000000"
/// longitude : "43.60000000"
/// service_provider_id : null
/// category_id : 24
/// user_id : 7

class Order {
  int id;
  String status;
  String amount;
  String notes;
  String latitude;
  String longitude;
  int service_provider_id;
  int category_id;
  int user_id;
  String service_provider_name;
  String status_name;
  String category_name;
  String user_name;
  User service_provider;
  ServiceValue category;
  User user;

  Order.fromJson(dynamic json) {
    id = json["id"];
    status = json["status"];
    amount = json["amount"];
    notes = json["notes"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    service_provider_id = json["service_provider_id"];
    category_id = json["category_id"];
    user_id = json["user_id"];
    service_provider_name = json["service_provider_name"];
    status_name = json["status_name"];
    category_name = json["category_name"];
    user_name = json["category_name"];
    if (json['category'] != null)
      category = ServiceValue.fromJson(json['category']);
    if (json['user'] != null) user = User.fromJSON(json['user']);
    if (json['service_provider'] != null)
      service_provider = User.fromJSON(json['service_provider']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["status"] = status;
    map["amount"] = amount;
    map["notes"] = notes;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["service_provider_id"] = service_provider_id;
    map["category_id"] = category_id;
    map["user_id"] = user_id;
    map["service_provider_name"] = service_provider_name;
    map["status_name"] = status_name;
    map["category_name"] = category_name;
    return map;
  }
}
