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

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.isCustomer}) : super(key: key);

  final bool isCustomer;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends StateMVC<SignUpPage> {
  UserController _con;
  String flagDropdownValue = 'AE';
  String codeDropdownValue = '50';

  final double _defaultPaddingMargin = 5;

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  _SignUpPageState() {
    _con = UserController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: Stack(children: <Widget>[
          Image.asset(
            'assets/images/bg.jpg',
            height: height,
            width: width,
            fit: BoxFit.fitHeight,
          ),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                  decoration:
                      new BoxDecoration(color: Colors.black.withOpacity(0.5)))),
          Align(
              alignment: Alignment.center,
              child: ContainerWithCircle(
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _description(),
                            SizedBox(height: _defaultPaddingMargin),
                            _form(),
                            SizedBox(height: _defaultPaddingMargin),
                            AppUtils.submitButton(
                                context,
                                widget.isCustomer
                                    ? S.of(context).signup_customer
                                    : S.of(context).signup_as_yalla, () {
                              _con.register();
                            }),
                            _facebookButton(),
                          ])),
                  Colors.white,
                  AssetImage(
                    'assets/images/logo.jpeg',
                  ))),
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

  Widget _submitButton() {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 10),
            onPressed: () {
              _con.login();
            },
            color: Theme.of(context).primaryColor,
            child: Text(
              widget.isCustomer
                  ? S.of(context).signup_customer
                  : S.of(context).signup_as_yalla,
              style: TextStyle(fontSize: 20, color: Colors.white),
            )));
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: _defaultPaddingMargin),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: Color(0xff1959a9)),
              alignment: Alignment.center,
              child: Icon(
                FontAwesomeIcons.facebookF,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(color: Color(0xff1959a9)),
              alignment: Alignment.center,
              child: Text(S.of(context).sign_up_fb,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
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
              S.of(context).sign_up_agree,
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xffB0B0B0),
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              S.of(context).terms_and_condition,
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

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'y',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
          children: [
            TextSpan(
              text: 'al',
              style: TextStyle(color: Color(0xffB0B0B0), fontSize: 20),
            ),
            TextSpan(
              text: 'la',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
          ]),
    );
  }

  Widget _description() {
    return Column(children: <Widget>[
      Text(
          widget.isCustomer
              ? S.of(context).signup_customer
              : S.of(context).signup_business_owner,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xffB0B0B0),
              fontWeight: FontWeight.bold,
              fontSize: 20)),
      SizedBox(height: 5),
      Text(
          widget.isCustomer
              ? S.of(context).signup_customer_desc
              : S.of(context).signup_business_desc,
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xffB0B0B0), fontSize: 12))
    ]);
  }

  Widget _phoneNumber() {
    return Row(children: [
      Flexible(
        child: _flagDropDown(),
        fit: FlexFit.tight,
      ),
      Flexible(
        child: _countryCodeDropDown(),
        fit: FlexFit.tight,
      ),
      Flexible(
        child: _phoneNumberField(),
        fit: FlexFit.tight,
        flex: 3,
      )
    ]);
  }

  Widget _nameWidget() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: TextFormField(
            controller: _nameController,
            onSaved: (input) => _con.user.name = input,
            validator: (input) =>
                input.isEmpty ? S.of(context).should_be_a_valid_name : null,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.person_outline, size: 20),
                hintText: S.of(context).name,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)))));
  }

  Widget _companyNameWidget() {
    return Visibility(
      visible: !widget.isCustomer,
      child: Container(
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
          child: TextFormField(
              controller: !widget.isCustomer ? _companyNameController : null,
              onSaved: (input) => _con.user.companyName = input,
              validator: (input) =>
                  input.isEmpty ? S.of(context).should_be_a_valid_name : null,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.person_outline, size: 20),
                  hintText: S.of(context).comapny_name,
                  hintStyle: TextStyle(color: Color(0xffC6C6C6))))),
    );
  }

  Widget _flagDropDown() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.darkGreyColor, width: 1.0),
                right: BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                value: flagDropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                onChanged: (String newValue) {
                  setState(() {
                    flagDropdownValue = newValue;
                  });
                },
                items: <String>['AE', 'US', 'TT', 'PK']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Flag(
                      value,
                      width: 30,
                      height: 25,
                      fit: BoxFit.contain,
                    ),
                  );
                }).toList())));
  }

  Widget _countryCodeDropDown() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.darkGreyColor, width: 1.0),
                right: BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          value: codeDropdownValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          onChanged: (String newValue) {
            setState(() {
              codeDropdownValue = newValue;
            });
          },
          items: <String>['50', '55', '52', '53']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )));
  }

  Widget _form() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.darkGreyColor, width: 1.0)),
        child: Form(
            key: _con.loginFormKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _companyNameWidget(),
                  _nameWidget(),
                  _emailWidget(),
                  _phoneNumber(),
                  _password()
                ])));
  }

  Widget _emailWidget() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: TextFormField(
            controller: _emailController,
            onSaved: (input) => _con.user.email = input,
            validator: (input) => !input.contains('@')
                ? S.of(context).should_be_a_valid_email
                : null,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.email, size: 20),
                hintText: S.of(context).email_address,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)))));
  }

  Widget _phoneNumberField() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: TextFormField(
            maxLength: 8,
            controller: _phoneController,
            onSaved: (input) => _con.user.phone = input,
            validator: (input) => input.length < 8
                ? S.of(context).should_be_a_valid_number
                : null,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                suffixIcon: Icon(Icons.phone_android, size: 20),
                hintText: S.of(context).mobile_number,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)))));
  }

  Widget _password() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        child: TextFormField(
            controller: _passController,
            onSaved: (input) => _con.user.password = input,
            validator: (input) => input.length < 3
                ? S.of(context).should_be_more_than_3_characters
                : null,
            textAlignVertical: TextAlignVertical.center,
            obscureText: true,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.lock, size: 20),
                hintText: S.of(context).create_password,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                border: InputBorder.none)));
  }
}
