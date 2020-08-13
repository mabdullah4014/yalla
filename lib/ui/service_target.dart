import 'dart:ui';

import 'package:arbi/model/category_response.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repo/settings_repository.dart' as settingsRepo;
import '../route_generator.dart';

class ServiceTargetPage extends StatefulWidget {
  ServiceTargetPage({Key key, this.params}) : super(key: key);

  final ServiceTargetPageParam params;

  @override
  _ServiceTargetPageState createState() => _ServiceTargetPageState();
}

class _ServiceTargetPageState extends StateMVC<ServiceTargetPage> {
  final double _defaultPaddingMargin = 10;

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
            child: Container(
                padding: EdgeInsets.all(_defaultPaddingMargin),
                child: generateTargets())));
  }

  Widget generateTargets() {
    
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
