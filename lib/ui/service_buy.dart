import 'dart:ui';

import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/ui/map_page.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repo/settings_repository.dart' as settingsRepo;

class ServiceBuyPage extends StatefulWidget {
  ServiceBuyPage({Key key, this.params}) : super(key: key);

  final ServiceBuyPageParam params;

  @override
  _ServiceBuyPageState createState() => _ServiceBuyPageState();
}

class _ServiceBuyPageState extends StateMVC<ServiceBuyPage> {
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
                    S.of(context).confirm_order,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .merge(TextStyle(color: Colors.white)),
                  );
                })),
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(10), child: _showDetail())));
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

  Widget _showDetail() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 100,
                height: 100,
                decoration:
                    ShapeDecoration(shape: CircleBorder(), color: Colors.white),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(widget.params.services.image_path))),
                ))
          ]),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              widget.params.services.name,
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).primaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('Price: ${widget.params.price}',
                style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
          ),
          AppUtils.submitButton(context, S.of(context).place_order, () {})
        ]);
  }
}

class ServiceBuyPageParam {
  ServiceBuyPageParam(
      {this.services, this.detailPageData, this.price, this.targetValues});

  final DetailPageData detailPageData;

  final ServiceValue services;

  final double price;

  final Map<String, String> targetValues;
}
