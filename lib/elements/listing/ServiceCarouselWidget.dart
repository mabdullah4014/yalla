import 'package:arbi/elements/listing/ServiceWidget.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/route_generator.dart';
import 'package:arbi/ui/service_buy.dart';
import 'package:arbi/ui/service_detail.dart';
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
                        ServiceValue serviceValues = widget.servicesList[index];
                        if (serviceValues.price != null &&
                            serviceValues.price != 0.0) {
                          Navigator.of(context).pushNamed(RouteGenerator.BUY,
                              arguments: ServiceBuyPageParam(
                                  detailPageData: DetailPageData(),
                                  services: serviceValues,
                                  price: serviceValues.price));
                        } else if (serviceValues.values != null &&
                            serviceValues.values.isNotEmpty) {
                          DetailPageData detailPageData = DetailPageData();

                          Navigator.of(context).pushNamed(RouteGenerator.DETAIL,
                              arguments: ServiceDetailPageParam(
                                  services: serviceValues,
                                  detailPageData: detailPageData));
                        }
                      },
                      child: ServiceWidget(
                          service: widget.servicesList.elementAt(index),
                          heroTag: widget.heroTag));
                }));
  }
}
