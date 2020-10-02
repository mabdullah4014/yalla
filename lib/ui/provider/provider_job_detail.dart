import 'dart:ui';

import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/cat_response.dart';
import 'package:arbi/model/customer_order_response.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:arbi/repo/settings_repository.dart' as settingsRepo;

class ProviderJobDetailPage extends StatefulWidget {
  ProviderJobDetailPage({Key key, this.order}) : super(key: key);

  final Order order;

  @override
  _ProviderJobDetailPageState createState() => _ProviderJobDetailPageState();
}

class _ProviderJobDetailPageState extends StateMVC<ProviderJobDetailPage> {
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
            title: Text(S.of(context).order_detail,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .merge(TextStyle(color: Colors.white)))),
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
      _labelValueWidget(S.of(context).customer_name, widget.order.user.name),
      SizedBox(height: 10),
      _labelValueWidget(S.of(context).price,
          '${widget.order.amount} ${settingsRepo.setting.value.defaultCurrency}'),
      SizedBox(height: 10),
      _labelValueWidget(S.of(context).job_type, widget.order.category.name),
      SizedBox(height: 10),
      _customerServiceAddress(),
      SizedBox(height: 10),
      _customerMobile()
    ]);
  }

  Widget targetView(String label, String value) {
    return Text('$label: $value',
        style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor));
  }

  Widget _serviceImage() {
    return Visibility(
      visible: (widget.order.category.image_path != null &&
          widget.order.category.image_path.isNotEmpty),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            width: 150,
            height: 150,
            decoration: ShapeDecoration(
                shape: CircleBorder(), color: Colors.grey.shade200),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.order.category.image_path))),
            ))
      ]),
    );
  }

  Widget _labelValueWidget(String label, String value, {Function onTap}) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: '$label: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).accentColor)),
          TextSpan(
              text: '$value',
              style:
                  TextStyle(fontSize: 20, color: Theme.of(context).accentColor))
        ])));
  }

  Widget _customerServiceAddress() {
    String latLng = '${widget.order.latitude},${widget.order.longitude}';
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(S.of(context).location,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor)),
            SizedBox(height: 5),
          ]),
          IconButton(
              icon: Icon(
                  (latLng != null && latLng.isNotEmpty)
                      ? Icons.location_on
                      : Icons.not_listed_location,
                  size: 30,
                  color: (latLng != null && latLng.isNotEmpty)
                      ? Colors.greenAccent
                      : Colors.redAccent),
              onPressed: () {
                AppUtils.openMap(widget.order.latitude, widget.order.longitude);
              })
        ],
      ),
    );
  }

  Widget _customerMobile() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '${S.of(context).mobile_number}: ${widget.order.user.phone_no}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                  fontSize: 18),
            ),
            SizedBox(height: 5),
          ]),
          IconButton(
              icon: Icon(Icons.call, size: 30, color: Colors.greenAccent),
              onPressed: () {
                launch('tel://${widget.order.user.phone_no}');
              })
        ],
      ),
    );
  }
}
