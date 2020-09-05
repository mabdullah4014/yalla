import 'dart:ui';

import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/user.dart';
import 'package:arbi/utils/app_colors.dart';
import 'package:arbi/utils/constants.dart';
import 'package:arbi/utils/pref_util.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'map_page.dart';

class CustomerProfilePage extends StatefulWidget {
  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends StateMVC<CustomerProfilePage> {
  UserController _con;
  String flagDropdownValue = 'IQ';
  String codeDropdownValue = '73';

  final double _defaultPaddingMargin = 10;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String currentLocation;

  _CustomerProfilePageState() {
    _con = UserController();

    _nameController.text = currentUser.value.name;
    _emailController.text = currentUser.value.email;
    setPhone(currentUser.value.phone_no);
    _passController.text = currentUser.value.password;
    currentLocation = currentUser.value.location();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation == null || currentLocation.isEmpty)
      currentLocation = S.of(context).tap_to_enter;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _nameWidget(),
                  _emailWidget(),
                  _phoneNumber(),
                  _password(),
                  Container(
                      color: Colors.grey.shade200,
                      height: _defaultPaddingMargin),
                  Container(
                      padding: EdgeInsets.all(_defaultPaddingMargin),
                      child: Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.black54),
                      )),
                  _location()
                ])));
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
            onChanged: (input) => _con.user.name = input,
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
            onChanged: (input) => _con.user.email = input,
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
        flex: 1,
      ),
      Flexible(
        child: _countryCodeDropDown(),
        fit: FlexFit.tight,
        flex: 1,
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
          items: Constants.PHONE_CODES
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
            maxLength: Constants.PHONE_LENGTH,
            controller: _phoneController,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            onChanged: (input) => _con.user.phone_no = input,
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
            onChanged: (input) => _con.user.password = input,
            textAlignVertical: TextAlignVertical.center,
            obscureText: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.lock, size: 20),
                hintText: S.of(context).password,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                border: InputBorder.none)));
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
                        _con.user.latitude = latLng.latitude.toString();
                        _con.user.longitude = latLng.longitude.toString();
                      });
                    });
              });
        },
        child: Container(
            padding: EdgeInsets.all(_defaultPaddingMargin),
            child: Row(children: <Widget>[
              Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    currentLocation,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor),
                  ),
                  flex: 5),
              Flexible(
                  fit: FlexFit.tight,
                  child: Icon(Icons.arrow_right, size: 30),
                  flex: 1)
            ])));
  }

  Widget _submit() {
    return AppUtils.submitButton(context, S.of(context).update, () {
      if (_isValidForm()) {
        _con.user.name = _nameController.text;
        _con.user.email = _emailController.text;
        _con.user.phone_no = getPhone();
        if (_passController.text != null && _passController.text.isNotEmpty) {
          _con.user.password = _passController.text;
          _con.user.password_confirmation = _passController.text;
        }
//        _con.user.push_notification_token =
//            PreferenceUtils.getString(PreferenceUtils.push_token);
        _con.user.user_type = currentUser.value.user_type;
        AppUtils.onLoading(context, message: S.of(context).updating);
        _con.update(onUpdateUser: (bool updated) {
          Navigator.of(context).pop();
          if (updated) {
            AppUtils.showMessage(
                context, S.of(context).app_name, S.of(context).user_updated);
          } else {
            AppUtils.showMessage(
                context, S.of(context).error, S.of(context).unavailable);
          }
        });
      }
    });
  }

  bool _isValidForm() {
    if (_nameController.text.isEmpty) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).should_be_a_valid_name);
      return false;
    } else if (_emailController.text.isEmpty ||
        !_emailController.text.contains('@')) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).should_be_a_valid_email);
      return false;
    } else if (_phoneController.text.isEmpty ||
        _phoneController.text.length < Constants.PHONE_LENGTH) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).should_be_a_valid_number);
      return false;
    }
    /*else if (_passController.text.isEmpty ||
        _passController.text.length < 3) {
      AppUtils.showMessage(context, S.of(context).error,
          S.of(context).should_be_more_than_3_characters);
      return false;
    } */
    return true;
  }

  String getPhone() {
    return Constants.defaultPhoneCode +
        codeDropdownValue +
        _phoneController.text;
  }

  void setPhone(String phoneNumber) {
    if (phoneNumber.length == 14) {
      String code = phoneNumber.substring(4, 6);
      String number = phoneNumber.substring(6);
      codeDropdownValue = code;
      _phoneController.text = number;
    } else {
      _phoneController.text = phoneNumber;
    }
  }
}
