/*
import 'dart:ui';

import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/utils/colors.dart';
import 'package:arbi/utils/utils.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CustomerProfilePage extends StatefulWidget {
  CustomerProfilePage({Key key}) : super(key: key);

  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends StateMVC<CustomerProfilePage> {

  UserController _con;
  String flagDropdownValue = 'IQ';
  String codeDropdownValue = '50';

  final double _defaultPaddingMargin = 10;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  _CustomerProfilePageState() {
    _con = UserController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context)),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            title: Text(
              S.of(context).profile,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .merge(TextStyle(color: Colors.white)),
            )),
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(_defaultPaddingMargin),
              child: Stack(children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _label(S.of(context).account_information),
                      SizedBox(height: _defaultPaddingMargin),
                      _form(),
                      SizedBox(height: _defaultPaddingMargin),
                      _submit()
                    ])
              ])),
        )));
  }

  Widget _label(String label) {
    return Text(label,
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade600));
  }

  Widget _form() {
    return Container(
        color: Colors.white,
        child: Form(
            key: _con.loginFormKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _nameWidget(),
                  _emailWidget(),
                  _phoneNumber(),
                  _password(),
                  Container(
                      color: Colors.grey.shade200,
                      height: _defaultPaddingMargin),
                  _categoriesContainer(),
                ])));
  }

  Widget _businessDetail() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            maxLines: 4,
            controller: _detailController,
            onSaved: (input) => _con.user.bio = input,
           keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: S.of(context).business_detail,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)))));
  }

  Widget _companyNameWidget() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            controller: _companyNameController,
            onSaved: (input) => _con.user.business_name = input,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.person_outline, size: 20),
                hintText: S.of(context).comapny_name,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)))));
  }

  Widget _nameWidget() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            controller: _nameController,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            onSaved: (input) => _con.user.name = input,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.person_outline, size: 20),
                hintText: S.of(context).name,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)))));
  }

  Widget _emailWidget() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            controller: _emailController,
            textInputAction: TextInputAction.done,
            onSaved: (input) => _con.user.email = input,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.email, size: 20),
                hintText: S.of(context).email_address,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)))));
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
                items: <String>['IQ']
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
          focusColor: Theme.of(context).primaryColor,
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

  Widget _phoneNumberField() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            maxLength: 8,
            controller: _phoneController,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            onSaved: (input) => _con.user.phone_no = input,
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
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
        child: TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            controller: _passController,
            onSaved: (input) => _con.user.password = input,
            textAlignVertical: TextAlignVertical.center,
            obscureText: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.lock, size: 20),
                hintText: S.of(context).create_password,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                border: InputBorder.none)));
  }

  Widget _categoriesContainer() {
    return MultiSelectFormField(
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
      fillColor: Colors.white,
      okButtonLabel: S.of(context).ok,
      cancelButtonLabel: S.of(context).cancel,
      hintText: S.of(context).please_select_more,
      initialValue: _myActivities,
      onSaved: (value) {
        if (value == null) return;
        setState(() {
          _myActivities = value;
        });
      },
    );
  }

  Widget _submit() {
    return AppUtils.submitButton(context, S.of(context).update, () {
      if (_isValidForm()) _con.login();
    });
  }

  bool _isValidForm() {
    if (_detailController.text.isEmpty) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).business_detail_empty);
      return false;
    } else if (_companyNameController.text.isEmpty) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).should_be_a_valid_name);
      return false;
    } else if (_nameController.text.isEmpty) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).should_be_a_valid_name);
      return false;
    } else if (_emailController.text.isEmpty ||
        !_emailController.text.contains('@')) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).should_be_a_valid_email);
      return false;
    } else if (_phoneController.text.isEmpty ||
        _phoneController.text.length < 8) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).should_be_a_valid_number);
      return false;
    } else if (_passController.text.isEmpty ||
        _passController.text.length < 3) {
      AppUtils.showMessage(context, S.of(context).error,
          S.of(context).should_be_more_than_3_characters);
      return false;
    } else if (_myActivities.length == 0) {
      AppUtils.showMessage(context, S.of(context).error,
          '${S.of(context).please_select_more} ${S.of(context).category}');
      return false;
    }
    return true;
  }
}
*/
