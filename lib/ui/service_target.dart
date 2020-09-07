import 'dart:ui';

import 'package:arbi/controller/cat_buy_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/check_service_request.dart';
import 'package:arbi/route_generator.dart';
import 'package:arbi/ui/map_page.dart';
import 'package:arbi/ui/service_buy.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repo/settings_repository.dart' as settingsRepo;

class ServiceTargetPage extends StatefulWidget {
  ServiceTargetPage({Key key, this.params}) : super(key: key);

  final ServiceTargetPageParam params;

  @override
  _ServiceTargetPageState createState() => _ServiceTargetPageState();
}

class _ServiceTargetPageState extends StateMVC<ServiceTargetPage> {
  final Map<String, String> targetValuesMap = Map();

  CheckServiceController checkServiceController;

  _ServiceTargetPageState() {
    checkServiceController = CheckServiceController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context)),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            title: ValueListenableBuilder(
                valueListenable: settingsRepo.setting,
                builder: (context, value, child) {
                  return Text(
                    widget.params.services.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .merge(TextStyle(color: Colors.white)),
                  );
                })),
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: generateTargets(),
                ))));
  }

  List<Widget> generateTargets() {
    List<Widget> widgetList = List();
    for (ServiceTarget target in widget.params.targets) {
      if (target.type == 'Input') {
        widgetList.add(inputField(target));
        widgetList.add(SizedBox(height: 10));
      } else if (target.type == 'Location') {
        widgetList.add(locationField(target));
        widgetList.add(SizedBox(height: 10));
      } else if (target.type == 'Checkbox') {
        widgetList.add(checkboxField(target));
        widgetList.add(SizedBox(height: 10));
      }
    }
    widgetList.add(submitButton());
    return widgetList;
  }

  Widget inputField(ServiceTarget target) {
    TextEditingController _controller = new TextEditingController();
    _controller.text = target.default_value;
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));
    targetValuesMap[target.target_value] = target.default_value;
    return TextField(
      enabled: target.is_enabled == 1 ? true : false,
      style: TextStyle(color: Theme.of(context).primaryColor),
      controller: _controller,
      onChanged: (input) => targetValuesMap[target.target_value] = input,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          hintText: '${S.of(context).enter} ${target.label}',
          labelText: target.label),
    );
  }

  Widget locationField(ServiceTarget target) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              target.label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            Visibility(
                visible: (targetValuesMap[target.target_value] != null &&
                    targetValuesMap[target.target_value].isNotEmpty),
                child: Text(
                    (targetValuesMap[target.target_value] != null &&
                            targetValuesMap[target.target_value].isNotEmpty)
                        ? targetValuesMap[target.target_value]
                        : "",
                    style: TextStyle(fontSize: 14)))
          ]),
          IconButton(
              icon: Icon(Icons.add_location,
                  size: 30, color: Theme.of(context).primaryColor),
              onPressed: () {
                showCupertinoModalBottomSheet(
                    barrierColor: Theme.of(context).primaryColor,
                    useRootNavigator: true,
                    context: context,
                    enableDrag: false,
                    builder: (context, scrollController) {
                      String latitude, longitude;
                      String currentLocation =
                          targetValuesMap[target.target_value];
                      if (currentLocation != null &&
                          currentLocation.isNotEmpty &&
                          !currentLocation.contains('location')) {
                        latitude = currentLocation.split(',')[0];
                        longitude = currentLocation.split(',')[1];
                      }
                      return MapPage(
                          latitude: latitude,
                          longitude: longitude,
                          onLatLngFinalized: (LatLng latLng) {
                            setState(() {
                              String coordinates =
                                  '${latLng.latitude},${latLng.longitude}';
                              targetValuesMap.putIfAbsent(
                                  target.target_value, () => coordinates);
                              targetValuesMap[target.target_value] =
                                  coordinates;
                            });
                          });
                    });
              })
        ],
      ),
    );
  }

  Widget checkboxField(ServiceTarget target) {
    targetValuesMap.putIfAbsent(target.target_value, () => "0");
    return CheckboxListTile(
        activeColor: Theme.of(context).primaryColor,
        title: Text(target.label), //
        value: targetValuesMap[target.target_value] == "0" ? false : true,
        onChanged: (newValue) {
          setState(() {
            if (newValue)
              targetValuesMap[target.target_value] = "1";
            else
              targetValuesMap[target.target_value] = "0";
          });
        });
  }

  Widget submitButton() {
    return AppUtils.submitButton(context, S.of(context).submit, () {
      bool allValuesDone = true;
      for (ServiceTarget target in widget.params.targets) {
        if (!targetValuesMap.containsKey(target.target_value) ||
            targetValuesMap[target.target_value].isEmpty) {
          allValuesDone = false;
          showDialogforError(target);
          break;
        }
      }
      if (allValuesDone) {
        AppUtils.onLoading(context, message: S.of(context).calculating_price);
        Map<String, String> copiedTargets = Map.from(targetValuesMap);
        checkServiceController.checkPrice(
            CheckServiceRequest(
                widget.params.services.id,
                widget.params.detailPageData.valuesIdList,
                copiedTargets), onPriceCheck: (checkResponse, checkRequest) {
          Navigator.of(context).pop();
          if (checkResponse == null) {
            AppUtils.showMessage(
                context, S.of(context).error, S.of(context).price_zero);
          } else {
            Navigator.of(context).pushNamed(RouteGenerator.BUY,
                arguments: ServiceBuyPageParam(
                    detailPageData: widget.params.detailPageData,
                    services: widget.params.services,
                    price: checkResponse.price,
                    checkServiceResponse: checkResponse,
                    targetValues: checkRequest.target));
          }
        });
      }
    });
  }

  void showDialogforError(ServiceTarget target) {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).app_name),
          content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
            Text('${S.of(context).enter} ${target.label} to proceed')
          ])),
          actions: <Widget>[
            FlatButton(
              child: Text(S.of(context).ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class ServiceTargetPageParam {
  ServiceTargetPageParam({this.services, this.detailPageData, this.targets});

  // object filled when navigating through values of services
  final DetailPageData detailPageData;

  // service object (item tapped on initially)
  final ServiceValue services;

  // parent value object of service (null initially)
  final List<ServiceTarget> targets;
}
