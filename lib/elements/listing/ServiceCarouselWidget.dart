import 'package:arbi/elements/listing/ServiceWidget.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/route_generator.dart';
import 'package:arbi/ui/service_buy.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/utils/constants.dart';
import 'package:flutter/material.dart';

import '../CircularLoadingWidget.dart';

class ServicesCarouselWidget extends StatelessWidget {
  final List<ServiceValue> servicesList;

  ServicesCarouselWidget({this.servicesList});

  @override
  Widget build(BuildContext context) {
    return (servicesList == null || servicesList.isEmpty)
        ? CircularLoadingWidget(height: 150)
        : Container(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: servicesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        ServiceValue serviceValue = servicesList[index];
                        Constants.onServiceItemClick(
                            context, DetailPageData(), serviceValue);
                      },
                      child: ServiceWidget(
                          service: servicesList.elementAt(index)));
                }));
  }
}
