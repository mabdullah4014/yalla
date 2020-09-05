import 'dart:io';

import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/place_order_request.dart';
import 'package:arbi/repo/settings_repository.dart';
import 'package:arbi/ui/service_buy.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/ui/service_target.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../route_generator.dart';

class Constants {
  static const int STATUS_INVALID = 401;
  static const int STATUS_APPROVAL = 402;
  static const int STATUS_SOMETHING_WENT_WRONG = 500;

  static const String defaultPhoneCode = '+964';
  static const int PHONE_LENGTH = 8;
  static PlaceOrderRequest placeOrderRequest = PlaceOrderRequest();
  static const List<String> PHONE_CODES = [
    '73',
    '74',
    '75',
    '76',
    '77',
    '78',
    '79'
  ];

  static InputDecoration getInputDecoration(
      BuildContext context, String hintText, String labelText,
      {Icon icon}) {
    return new InputDecoration(
        hintText: hintText,
        labelText: labelText,
        icon: icon,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .merge(TextStyle(color: Theme.of(context).focusColor)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).hintColor.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).hintColor)),
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .merge(TextStyle(color: Theme.of(context).hintColor)));
  }

  static void proceedToMainPage(BuildContext context) {
    Navigator.of(context).popAndPushNamed(RouteGenerator.MAIN);
  }

  static void onServiceItemClick(BuildContext context,
      DetailPageData detailPageData, ServiceValue serviceValue) {
    if (serviceValue.values != null && serviceValue.values.isNotEmpty) {
      Navigator.of(context).pushNamed(RouteGenerator.DETAIL,
          arguments: ServiceDetailPageParam(
              services: serviceValue, detailPageData: detailPageData));
    } else if (serviceValue.targets != null &&
        serviceValue.targets.isNotEmpty) {
      Navigator.of(context).pushNamed(RouteGenerator.TARGET,
          arguments: ServiceTargetPageParam(
              services: serviceValue,
              detailPageData: detailPageData,
              targets: serviceValue.targets));
    } else if (serviceValue.price != null && serviceValue.price != 0.0) {
      Navigator.of(context).pushNamed(RouteGenerator.BUY,
          arguments: ServiceBuyPageParam(
              detailPageData: DetailPageData(),
              services: serviceValue,
              price: serviceValue.price));
    }
  }

  static Map<String, String> getHeader() {
    Map<String, String> headerMap = Map();
    headerMap[HttpHeaders.contentTypeHeader] = 'application/json';
    headerMap['locale'] = setting.value.mobileLanguage.value.languageCode;

    if (currentUser.value != null && currentUser.value.auth_token != null) {
      headerMap[HttpHeaders.authorizationHeader] =
          'Bearer ${currentUser.value.auth_token}';
    }
    return headerMap;
  }
}
