import 'dart:ui';

import 'package:arbi/model/category_response.dart';
import 'package:arbi/ui/service_target.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repo/settings_repository.dart' as settingsRepo;
import '../route_generator.dart';

class ServiceDetailPage extends StatefulWidget {
  ServiceDetailPage({Key key, this.params}) : super(key: key);

  final ServiceDetailPageParam params;

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends StateMVC<ServiceDetailPage> {
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
                child: generateListOrGrid())));
  }

  Widget generateListOrGrid() {
    if (widget.params.serviceValues != null) {
      if (widget.params.serviceValues.viewType == 'list') {
        return generateList(values: widget.params.serviceValues.values);
      } else {
        return generateGrid(values: widget.params.serviceValues.values);
      }
    } else {
      if (widget.params.services.viewType == 'list') {
        return generateList(values: widget.params.services.values);
      } else {
        return generateGrid(values: widget.params.services.values);
      }
    }
  }

  Widget generateGrid({List<ServiceValue> values}) {
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
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
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  values[index].name,
                  style: TextStyle(fontSize: 22.0),
                ),
              )));
        });
  }

  Widget getGridItem(ServiceValue serviceValue) {
    return InkWell(
        onTap: () {
          itemTap(serviceValue);
        },
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Card(
                color: Colors.white,
                elevation: 5,
                child: SizedBox(
                    child: Column(children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: serviceValue.image,
                          placeholder: (context, url) => Image.asset(
                              'assets/images/loading.gif',
                              fit: BoxFit.contain),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error))),
                  Container(
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(serviceValue.name,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15))))
                ])))));
  }

  void itemTap(ServiceValue serviceValue) {
    if (serviceValue.values != null && serviceValue.values.isNotEmpty) {
      DetailPageData detailPageData = widget.params.detailPageData;
      if (detailPageData.valuesIdList == null) {
        detailPageData.valuesIdList = List();
      }
      detailPageData.valuesIdList.add(serviceValue.id);
      print('ValuesId:${detailPageData.valuesIdList}');
      Navigator.of(context).pushNamed(RouteGenerator.DETAIL,
          arguments: ServiceDetailPageParam(
              services: widget.params.services,
              detailPageData: detailPageData,
              serviceValues: serviceValue));
    } else if (serviceValue.target != null && serviceValue.target.isNotEmpty) {
      DetailPageData detailPageData = widget.params.detailPageData;
      if (detailPageData.valuesIdList == null) {
        detailPageData.valuesIdList = List();
      }
      detailPageData.valuesIdList.add(serviceValue.id);
      print('ValuesId:${detailPageData.valuesIdList}');
      Navigator.of(context).pushNamed(RouteGenerator.TARGET,
          arguments: ServiceTargetPageParam(
              services: widget.params.services,
              detailPageData: detailPageData,
              target: serviceValue.target));
    } else {}
  }
}

class ServiceDetailPageParam {
  ServiceDetailPageParam(
      {this.services, this.detailPageData, this.serviceValues});

  // object filled when navigating through values of services
  final DetailPageData detailPageData;

  // service object (item tapped on initially)
  final YallaService services;

  // parent value object of service (null initially)
  final ServiceValue serviceValues;
}

class DetailPageData {
  DetailPageData({this.valuesIdList});

  List<int> valuesIdList;
}
