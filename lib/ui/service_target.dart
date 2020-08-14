import 'dart:ui';

import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/category_response.dart';
import 'package:arbi/ui/map_page.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/utils/utils.dart';
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
    for (Target target in widget.params.target) {
      if (target.type == 'input') {
        widgetList.add(inputField(target));
        widgetList.add(SizedBox(height: 10));
      } else if (target.type == 'location') {
        widgetList.add(locationField(target));
        widgetList.add(SizedBox(height: 10));
      } else if (target.type == 'checkbox') {
        widgetList.add(checkboxField(target));
        widgetList.add(SizedBox(height: 10));
      }
    }
    widgetList.add(submitButton());
    return widgetList;
  }

  Widget inputField(Target target) {
    return TextField(
      onChanged: (input) =>
          targetValuesMap.putIfAbsent(target.targetValue, () => input),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.grey, width: 1)),
          hintText: '${S.of(context).enter} ${target.label}',
          labelText: target.label),
    );
  }

  Widget locationField(Target target) {
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
            /*Visibility(
              visible: (targetValuesMap[target.label] != null &&
                  targetValuesMap[target.label].isNotEmpty),
              child: Text(
                (targetValuesMap[target.label] != null &&
                        targetValuesMap[target.label].isNotEmpty)
                    ? targetValuesMap[target.label]
                    : "",
                style: TextStyle(fontSize: 14),
              ),
            )
            */
            Text(
              (targetValuesMap[target.targetValue] != null &&
                      targetValuesMap[target.targetValue].isNotEmpty)
                  ? targetValuesMap[target.targetValue]
                  : "",
              style: TextStyle(fontSize: 14),
            )
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
                      return MapPage(onLatLngFinalized: (LatLng latLng) {
                        setState(() {
                          String coordinates =
                              '${latLng.latitude},${latLng.longitude}';
                          targetValuesMap.putIfAbsent(
                              target.targetValue, () => coordinates);
                          targetValuesMap[target.targetValue] = coordinates;
                        });
                      });
                    });
              })
        ],
      ),
    );
  }

  Widget checkboxField(Target target) {
    targetValuesMap.putIfAbsent(target.targetValue, () => "0");
    return CheckboxListTile(
        activeColor: Theme.of(context).primaryColor,
        title: Text(target.label), //
        value: targetValuesMap[target.targetValue] == "0" ? false : true,
        onChanged: (newValue) {
          setState(() {
            if (newValue)
              targetValuesMap[target.targetValue] = "1";
            else
              targetValuesMap[target.targetValue] = "0";
          });
        });
  }

  Widget submitButton() {
    return AppUtils.submitButton(context, S.of(context).submit, () {
      bool allValuesDone = true;
      for (Target target in widget.params.target) {
        if (!targetValuesMap.containsKey(target.targetValue)) {
          allValuesDone = false;
          showDialogforError(target);
          break;
        }
      }
      if (allValuesDone) print(targetValuesMap.toString());
    });
  }

  void showDialogforError(Target target) {
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
  ServiceTargetPageParam({this.services, this.detailPageData, this.target});

  // object filled when navigating through values of services
  final DetailPageData detailPageData;

  // service object (item tapped on initially)
  final YallaService services;

  // parent value object of service (null initially)
  final List<Target> target;
}
