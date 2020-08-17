import 'dart:ui';

import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/utils/colors.dart';
import 'package:arbi/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route_generator.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage> {
  UserController _con;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  _LoginPageState() {
    _con = UserController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              AppUtils.cityBg(context),
              AppUtils.cityblur(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        SizedBox(height: 50),
                        _emailPasswordWidget(),
                        SizedBox(height: 10),
                        AppUtils.submitButton(context, S.of(context).login, () {
                          if (_isValidForm()) {
                            _con.login();
                          }
                        }),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(S.of(context).forgot_password,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ),
                        _facebookButton(),
                        SizedBox(height: 10),
                        _createAccountLabel(),
                      ],
                    ),
                  )),
              Positioned(top: 10, right: 10, child: _backButton()),
            ],
          ),
        )));
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
    return InkWell(
        onTap: () {
          _con.login();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          color: Theme.of(context).primaryColor,
          child: Text(
            S.of(context).login,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Widget _facebookButton() {
    return InkWell(
        onTap: () {
          _fbLogin();
        },
        child: Container(
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 10),
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
                  child: Text(S.of(context).login_fb,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteGenerator.SIGNUP_AS);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              S.of(context).dont_have_account,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              S.of(context).signup,
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
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
          children: [
            TextSpan(
              text: 'al',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            TextSpan(
              text: 'la',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _con.loginFormKey,
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.greyColor, width: 1.0))),
              child: TextFormField(
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  controller: _emailController,
                  onSaved: (input) => _con.user.email = input,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email, size: 20),
                      hintText: S.of(context).email_address,
                      hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true))),
          Container(
              child: TextFormField(
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  controller: _passController,
                  onSaved: (input) => _con.user.password = input,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: true,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.lock, size: 20),
                      hintText: S.of(context).password,
                      hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true)))
        ],
      ),
    );
  }

  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';

  Future<Null> _fbLogin() async {
    facebookSignIn.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    facebookSignIn.logIn(['email']).then((result) {
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          http
              .get(
                  'https://graph.facebook.com/v2.12/me?fields=name,first_name,picture,last_name,email&access_token=${accessToken.token}')
              .then((graphResponse) {
            print(graphResponse.body);
            AppUtils.showMessage(context, S.of(context).login_fb, '''
         Profile: ${graphResponse.body}
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
          });
          break;
        case FacebookLoginStatus.cancelledByUser:
          AppUtils.showMessage(
              context, S.of(context).login_fb, 'Login cancelled by the user.');
          break;
        case FacebookLoginStatus.error:
          AppUtils.showMessage(
              context,
              S.of(context).login_fb,
              'Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
    });
  }

  Future<Null> _fbLogOut() async {
    await facebookSignIn.logOut();
    AppUtils.showMessage(context, S.of(context).login_fb, 'Logged out.');
  }

  bool _isValidForm() {
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).should_be_a_valid_email);
      return false;
    } else if (_passController.text.isEmpty ||
        _passController.text.length < 3) {
      AppUtils.showMessage(context, S.of(context).error,
          S.of(context).should_be_more_than_3_characters);
      return false;
    }
    return true;
  }
}
