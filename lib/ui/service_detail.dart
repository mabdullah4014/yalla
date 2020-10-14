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
//    double width = MediaQuery.of(context).size.width / 3;
//    double height = MediaQuery.of(context).size.height / 5;
//    print(
//        '${MediaQuery.of(context).size.width},${MediaQuery.of(context).size.height},'
//        '$width,$height,${width / height}');
    return GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        children: List.generate(values.length, (index) {
          return getGridItem(values[index]);
        }));
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
            child: Column(children: <Widget>[
          // Image of the card
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                  height: gridItemDimension,
                  width: gridItemDimension,
                  child: Stack(fit: StackFit.expand, children: <Widget>[
                    CachedNetworkImage(
                        imageUrl: serviceValue.image_path,
                        fit: BoxFit.cover,
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
                  ])))
        ])));
  }

  void itemTap(ServiceValue serviceValue) {
    DetailPageData detailPageData = widget.params.detailPageData;
    if (detailPageData.valuesIdList == null) {
      detailPageData.valuesIdList = List();
    }
    detailPageData.valuesIdList.add(serviceValue.id);
    Constants.onServiceItemClick(context, detailPageData, serviceValue);
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
