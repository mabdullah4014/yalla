import 'dart:ui';

import 'package:arbi/controller/cat_buy_controller.dart';
import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/check_service_response.dart';
import 'package:arbi/route_generator.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:arbi/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repo/settings_repository.dart' as settingsRepo;
import 'login.dart';
import 'map_page.dart';

class ServiceBuyPage extends StatefulWidget {
  ServiceBuyPage({Key key, this.params}) : super(key: key);

  final ServiceBuyPageParam params;

  @override
  _ServiceBuyPageState createState() => _ServiceBuyPageState();
}

class _ServiceBuyPageState extends StateMVC<ServiceBuyPage> {
  final Map<String, String> targetValuesMap = Map();

  CheckServiceController checkServiceController;
  String currentLocation;
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkServiceController = CheckServiceController();
    currentLocation = 'Tap to enter location';
  }

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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _serviceImage(),
      SizedBox(height: 10),
      _serviceName(),
      SizedBox(height: 10),
      _serviceDesc(),
      SizedBox(height: 10),
      _servicePrice(),
      SizedBox(height: 10),
      Visibility(
        visible: _showDistance().isNotEmpty,
        child: Text('${S.of(context).distance}: ${_showDistance()}',
            style:
                TextStyle(fontSize: 20, color: Theme.of(context).primaryColor)),
      ),
      SizedBox(height: 10),
      _showTargetValues(),
      Container(
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(color: Colors.black, width: 1.0),
                  top: BorderSide(color: Colors.black, width: 1.0),
                  right: BorderSide(color: Colors.black, width: 1.0),
                  bottom: BorderSide(color: Colors.black, width: 1.0))),
          child: TextFormField(
              controller: notesController,
              style: TextStyle(color: Theme.of(context).primaryColor),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: S.of(context).notes,
                  hintStyle: TextStyle(color: Color(0xffC6C6C6))))),
      SizedBox(height: 10),
      Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Location',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Colors.black54),
          )),
      _location(),
      SizedBox(height: 10),
      AppUtils.submitButton(context, S.of(context).place_order, () {
        if (_isValidForm()) {
          Constants.placeOrderRequest.price = widget.params.price.toString();
          Constants.placeOrderRequest.cat_values =
              widget.params.detailPageData.valuesIdList;
          Constants.placeOrderRequest.target = widget.params.targetValues;
          Constants.placeOrderRequest.category_id = widget.params.services.id;
          Constants.placeOrderRequest.notes = notesController.text;
          if (currentUser.value == null ||
              currentUser.value.auth == null ||
              currentUser.value.auth == false) {
            AppUtils.showMessage(context, S.of(context).app_name,
                S.of(context).login_to_continue, callback: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(RouteGenerator.LOGIN,
                  arguments:
                      LoginPageParam(comingFrom: LoginPage.FROM_PLACE_ORDER));
            });
          } else {
            Constants.placeOrderRequest.user_id =
                int.parse(currentUser.value.id);
            AppUtils.onLoading(context);
            checkServiceController.placeOrder(Constants.placeOrderRequest,
                onOrderPlaced: (bool placed) {
              Navigator.of(context).pop();
              if (placed) {
                AppUtils.showMessage(
                    context, S.of(context).app_name, S.of(context).order_placed,
                    callback: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
              } else {
                AppUtils.showMessage(context, S.of(context).app_name,
                    S.of(context).order_not_placed);
              }
            });
          }
        }
      })
    ]);
  }

  Widget _showTargetValues() {
    if (widget.params.targetValues != null &&
        widget.params.targetValues.isNotEmpty &&
        widget.params.services.targets != null &&
        widget.params.services.targets.isNotEmpty &&
        widget.params.services.targets
            .where((element) => element.type != 'Location')
            .isNotEmpty) {
      List<Widget> widgets = [];
      for (ServiceTarget serviceTarget in widget.params.services.targets
          .where((element) => element.type != 'Location')) {
        String label = serviceTarget.label;
        String value = widget.params.targetValues[serviceTarget.target_value];
        widgets.add(targetView(label, value));
      }
      widgets.add(SizedBox(height: 10));
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
    }
    return SizedBox(height: 10);
  }

  Widget targetView(String label, String value) {
    return Text('$label: $value',
        style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor));
  }

  Widget _location() {
    return InkWell(
        onTap: () {
          showCupertinoModalBottomSheet(
              barrierColor: Theme.of(context).primaryColor,
              useRootNavigator: true,
              context: context,
              enableDrag: false,
              builder: (context, scrollController) {
                String latitude, longitude;
                if (currentLocation != null &&
                    currentLocation.isNotEmpty &&
                    !currentLocation.contains('location')) {
                  latitude = currentLocation.split(',')[0];
                  longitude = currentLocation.split(',')[1];
                }
                return MapPage(
                    latitude: latitude,
                    longitude: longitude,
                    onLatLngFinalized: (LatLng latLng) {
                      setState(() {
                        String coordinates =
                            '${latLng.latitude},${latLng.longitude}';
                        currentLocation = coordinates;
                        Constants.placeOrderRequest.latitude =
                            latLng.latitude.toString();
                        Constants.placeOrderRequest.longitude =
                            latLng.longitude.toString();
                      });
                    });
              });
        },
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(children: <Widget>[
              Flexible(
                  fit: FlexFit.tight,
                  child: Text(currentLocation,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor)),
                  flex: 5),
              Flexible(
                  fit: FlexFit.tight,
                  child: Icon(Icons.arrow_right, size: 30),
                  flex: 1)
            ])));
  }

  bool _isValidForm() {
    if (currentLocation == null ||
        currentLocation.isEmpty ||
        currentLocation.contains('location')) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).enter_location);
      return false;
    }
    return true;
  }

  String _showDistance() {
    if (widget.params.checkServiceResponse != null &&
        widget.params.checkServiceResponse.distance != null) {
      return '${widget.params.checkServiceResponse.distance.toStringAsFixed(2)} '
          '${S.of(context).km}';
    }
    return "";
  }

  Widget _serviceImage() {
    return Visibility(
      visible: (widget.params.services.image_path != null &&
          widget.params.services.image_path.isNotEmpty),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
                shape: CircleBorder(), color: Colors.grey.shade200),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.params.services.image_path))),
            ))
      ]),
    );
  }

  Widget _serviceName() {
    return Text('${S.of(context).service}: ${widget.params.services.name}',
        style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor));
  }

  Widget _servicePrice() {
    return Visibility(
        visible: widget.params.price != null && widget.params.price != 0,
        child: Text(
            '${S.of(context).price}: ${widget.params.price} ${settingsRepo.setting.value.defaultCurrency}',
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).primaryColor)));
  }

  Widget _serviceDesc() {
    return Visibility(
        visible: widget.params.services.description != null &&
            widget.params.services.description.isNotEmpty,
        child: Text(
            '${S.of(context).description}:\n${widget.params.services.description}',
            style: TextStyle(
                fontSize: 20, color: AppUtils.getColorFromHash('#C5C5C5'))));
  }
}

class ServiceBuyPageParam {
  ServiceBuyPageParam(
      {this.services,
      this.detailPageData,
      this.price,
      this.checkServiceResponse,
      this.targetValues});

  final DetailPageData detailPageData;

  final ServiceValue services;

  final double price;

  final CheckServiceResponse checkServiceResponse;

  final Map<String, String> targetValues;
}
