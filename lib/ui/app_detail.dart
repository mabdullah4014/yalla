import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AppDetailPage extends StatefulWidget {
  AppDetailPage({Key key, this.appDetailObject}) : super(key: key);

  final AppDetailObject appDetailObject;

  @override
  _AppDetailPageState createState() => _AppDetailPageState();
}

class _AppDetailPageState extends StateMVC<AppDetailPage> {
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
            title: Text(widget.appDetailObject.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .merge(TextStyle(color: Colors.white)))),
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(10), child: _showDetail())));
  }

  Widget _showDetail() {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(widget.appDetailObject.text)));
  }
}

class AppDetailObject {
  AppDetailObject({this.text, this.title});

  final String text;
  final String title;
}
