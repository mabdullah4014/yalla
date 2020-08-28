import 'package:arbi/elements/listing/ServiceWidget.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/route_generator.dart';
import 'package:arbi/ui/service_buy.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/utils/constants.dart';
import 'package:flutter/material.dart';

import '../CircularLoadingWidget.dart';

class ServicesCarouselWidget extends StatefulWidget {
  List<ServiceValue> servicesList;
  String heroTag;

  ServicesCarouselWidget({Key key, this.servicesList, this.heroTag})
      : super(key: key);

  @override
  _ServicesCarouselWidgetState createState() => _ServicesCarouselWidgetState();
}

class _ServicesCarouselWidgetState extends State<ServicesCarouselWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.servicesList == null || widget.servicesList.isEmpty)
        ? CircularLoadingWidget(height: 150)
        : Container(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.servicesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        ServiceValue serviceValue = widget.servicesList[index];
                        Constants.onServiceItemClick(
                            context, DetailPageData(), serviceValue);
                      },
                      child: ServiceWidget(
                          service: widget.servicesList.elementAt(index),
                          heroTag: widget.heroTag));
                }));
  }
}
