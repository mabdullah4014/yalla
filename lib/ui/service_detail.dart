import 'dart:ui';

import 'package:arbi/model/cat_response.dart';
import 'package:arbi/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repo/settings_repository.dart' as settingsRepo;

class ServiceDetailPage extends StatefulWidget {
  ServiceDetailPage({Key key, this.params}) : super(key: key);

  final ServiceDetailPageParam params;

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends StateMVC<ServiceDetailPage> {
  final double _defaultPaddingMargin = 10;

  static final double gridItemDimension = 170;

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
                child: generateListOrGrid())));
  }

  Widget generateListOrGrid() {
    if (widget.params.services.view_type == 'list') {
      return generateList(values: widget.params.services.values);
    } else {
      return generateGrid(values: widget.params.services.values);
    }
  }

  Widget generateGrid({List<ServiceValue> values}) {
    List<Widget> widgetsList = [];
    for (var i = 0; i < values.length; i += 2) {
      ServiceValue item1 = values[i];
      ServiceValue item2;
      int j = (i + 1);
      if (j < values.length) {
        item2 = values[j];
      }
      widgetsList.add(createRow(item1, item2));
      widgetsList.add(SizedBox(height: 10));
    }
    return SingleChildScrollView(child: Column(children: widgetsList));
  }

  Widget generateList({List<ServiceValue> values}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: values.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                itemTap(values[index]);
              },
              child: _listItem(values[index]));
        });
  }

  Widget _listItem(ServiceValue serviceValue) {
    return Card(
        child: Column(children: <Widget>[
      ListTile(
          leading: Container(
              width: 50,
              height: 50,
              decoration: ShapeDecoration(
                  shape: CircleBorder(), color: Colors.grey.shade200),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(serviceValue.image_path))),
              )),
          title: Text(serviceValue.name))
      /*subtitle: Visibility(
              visible: (serviceValue.description != null &&
                  serviceValue.description.isNotEmpty),
              child: Text('${serviceValue.description}')))*/
    ]));
  }

  Widget getGridItem(ServiceValue serviceValue) {
    return InkWell(
        onTap: () {
          itemTap(serviceValue);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2.2,
          height: 180,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Stack(fit: StackFit.expand, children: <Widget>[
                CachedNetworkImage(
                    imageUrl: serviceValue.image_path,
                    fit: BoxFit.contain,
                    width: gridItemDimension),
                Positioned(child: Container(color: Colors.black38)),
                Positioned(
                    bottom: 5,
                    left: 10,
                    right: 10,
                    child: Text(serviceValue.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)))
              ])),
        ));
  }

  void itemTap(ServiceValue serviceValue) {
    DetailPageData detailPageData = widget.params.detailPageData;
    if (detailPageData.valuesIdList == null) {
      detailPageData.valuesIdList = List();
    }
    detailPageData.valuesIdList.add(serviceValue.id);
    Constants.onServiceItemClick(context, detailPageData, serviceValue);
  }

  Widget createRow(ServiceValue item1, ServiceValue item2) {
    List<Widget> widgetsList = [];
    if (item1 != null) widgetsList.add(getGridItem(item1));
    if (item2 != null) widgetsList.add(getGridItem(item2));
    return Row(
        mainAxisAlignment: widgetsList.length == 2
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: widgetsList);
  }
}

class ServiceDetailPageParam {
  ServiceDetailPageParam({this.services, this.detailPageData});

  // object filled when navigating through values of services
  final DetailPageData detailPageData;

  // service object
  final ServiceValue services;
}

class DetailPageData {
  DetailPageData({this.valuesIdList});

  List<int> valuesIdList;
}
