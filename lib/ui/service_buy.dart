import 'dart:ui';

import 'package:arbi/controller/cat_buy_controller.dart';
import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/place_order_request.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  CheckServiceController checkServiceController;
  PlaceOrderRequest placeOrderRequest;

  _ServiceBuyPageState() {
    checkServiceController = CheckServiceController();
    placeOrderRequest = PlaceOrderRequest();
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
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
      SizedBox(height: 10),
      Text('${S.of(context).service}: ${widget.params.services.name}',
          style: TextStyle(fontSize: 25, color: Theme.of(context).accentColor)),
      SizedBox(height: 10),
      Text('${S.of(context).price}: ${widget.params.price}',
          style:
              TextStyle(fontSize: 25, color: Theme.of(context).primaryColor)),
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
              style: TextStyle(color: Theme.of(context).primaryColor),
              maxLines: 4,
              onChanged: (input) => placeOrderRequest.notes = input,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: S.of(context).notes,
                  hintStyle: TextStyle(color: Color(0xffC6C6C6))))),
      SizedBox(height: 10),
      AppUtils.submitButton(context, S.of(context).place_order, () {
        placeOrderRequest.user_id = int.parse(currentUser.value.id);
        placeOrderRequest.price = widget.params.price.toString();
        placeOrderRequest.cat_values =
            widget.params.detailPageData.valuesIdList;
        placeOrderRequest.target = widget.params.targetValues;
        placeOrderRequest.category_id = widget.params.services.id;
        checkServiceController.placeOrder(placeOrderRequest,
            onPriceCheck: (double price) {});
      })
    ]);
  }

  Widget _showTargetValues() {
    if (widget.params.targetValues != null &&
        widget.params.targetValues.isNotEmpty &&
        widget.params.services.targets != null &&
        widget.params.services.targets.isNotEmpty) {
      List<Widget> widgets = [];
      widgets.add(SizedBox(height: 10));
      widgets.add(
          Text('Values', style: TextStyle(fontSize: 25, color: Colors.black)));
      widgets.add(SizedBox(height: 10));
      for (ServiceTarget serviceTarget in widget.params.services.targets) {
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
}

class ServiceBuyPageParam {
  ServiceBuyPageParam(
      {this.services, this.detailPageData, this.price, this.targetValues});

  final DetailPageData detailPageData;

  final ServiceValue services;

  final double price;

  final Map<String, String> targetValues;
}
