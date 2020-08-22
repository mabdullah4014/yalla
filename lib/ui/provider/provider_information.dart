import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProviderCompleteSignupPage extends StatefulWidget {
  ProviderCompleteSignupPage({Key key}) : super(key: key);

  @override
  _ProviderCompleteSignupPageState createState() =>
      _ProviderCompleteSignupPageState();
}

class _ProviderCompleteSignupPageState
    extends StateMVC<ProviderCompleteSignupPage> {
  UserController _con;
  List _myActivities;
  final double _defaultPaddingMargin = 5;

  _ProviderCompleteSignupPageState() {
    _con = UserController();
    _myActivities = [];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: Stack(children: <Widget>[
          AppUtils.cityBg(context),
          AppUtils.cityblur(),
          Column(children: <Widget>[
            MultiSelectFormField(
                autovalidate: false,
                dataSource: [
                  {
                    "display": "Running",
                    "value": "Running",
                  },
                  {
                    "display": "Climbing",
                    "value": "Climbing",
                  },
                  {
                    "display": "Walking",
                    "value": "Walking",
                  },
                  {
                    "display": "Swimming",
                    "value": "Swimming",
                  },
                  {
                    "display": "Soccer Practice",
                    "value": "Soccer Practice",
                  },
                  {
                    "display": "Baseball Practice",
                    "value": "Baseball Practice",
                  },
                  {
                    "display": "Football Practice",
                    "value": "Football Practice",
                  }
                ],
                textField: 'display',
                valueField: 'value',
                titleText: S.of(context).categories,
                okButtonLabel: S.of(context).ok,
                cancelButtonLabel: S.of(context).cancel,
                hintText: S.of(context).please_select_more,
                initialValue: _myActivities,
                onSaved: (value) {
                  if (value == null) return;
                  setState(() {
                    _myActivities = value;
                  });
                })
          ])
        ])));
  }
}
