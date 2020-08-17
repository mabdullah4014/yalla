import 'dart:ui';

import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/elements/circleWidgetOnTop.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/utils/colors.dart';
import 'package:arbi/utils/utils.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route_generator.dart';

class SelectSignUpPage extends StatefulWidget {
  @override
  _SelectSignUpPageState createState() => _SelectSignUpPageState();
}

class _SelectSignUpPageState extends StateMVC<SelectSignUpPage> {
  final double _defaultPaddingMargin = 10;

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
          Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _description(),
                  SizedBox(height: _defaultPaddingMargin * 3),
                  _signUpWidget(S.of(context).looking_for_service,
                      S.of(context).signup_customer, true),
                  SizedBox(height: _defaultPaddingMargin * 3),
                  _signUpWidget(S.of(context).are_business_owner,
                      S.of(context).signup_as_yalla, false),
                ],
              )),
          Positioned(
              top: _defaultPaddingMargin,
              right: _defaultPaddingMargin,
              child: _backButton()),
          Positioned(
              bottom: 0,
              left: _defaultPaddingMargin,
              right: _defaultPaddingMargin,
              child: _createAccountLabel()),
        ])));
  }

  Widget _backButton() {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.clear,
          size: 30,
          color: Colors.white,
        ));
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              S.of(context).already_account,
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xffB0B0B0),
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              S.of(context).login,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _description() {
    return Column(children: <Widget>[
      Text(S.of(context).signup,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
      SizedBox(height: 5),
      Text(S.of(context).choose_account_type,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 18))
    ]);
  }

  Widget _signUpWidget(String description, String buttonText, bool isCustomer) {
    return ContainerWithCircle(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(description,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xffB0B0B0), fontSize: 16)),
                  SizedBox(height: _defaultPaddingMargin * 2),
                  AppUtils.submitButton(context, buttonText, () {
                    Navigator.of(context).pushNamed(RouteGenerator.SIGNUP,
                        arguments: isCustomer);
                  }),
                ])),
        childBgColor: Colors.white,
        imageProvider: AssetImage(
          'assets/images/logo_circle.png',
        ));
  }
}
