import 'dart:ui';

import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/elements/circleWidgetOnTop.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/user.dart';
import 'package:arbi/ui/image_picker_example.dart';
import 'package:arbi/utils/app_colors.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:arbi/utils/constants.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../route_generator.dart';
import 'image_picker_example.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.signUpPageParam}) : super(key: key);

  final SignUpPageParam signUpPageParam;

  @override
  _SignUpPageState createState() => _SignUpPageState(signUpPageParam);
}

class _SignUpPageState extends StateMVC<SignUpPage> {
  UserController _con;
  String flagDropdownValue = 'IQ';
  String codeDropdownValue = '73';

  final double _defaultPaddingMargin = 5;
  bool isCustomer;

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  PickedFile profilePic;
  PickedFile idCardFront;
  PickedFile idCardBack;

  _SignUpPageState(SignUpPageParam signUpPageParam) {
    _con = UserController();
    isCustomer = signUpPageParam.isCustomer;
    _con.user.user_type =
        signUpPageParam.isCustomer ? User.CUSTOMER : User.SERVICE_PROVIDER;
    if (signUpPageParam.name != null) {
      _nameController.text = signUpPageParam.name;
    }
    if (signUpPageParam.email != null) {
      _emailController.text = signUpPageParam.email;
    }
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: Builder(
            builder: (scaffoldContext) => SafeArea(
                    child: Stack(children: <Widget>[
                  AppUtils.cityBg(context),
                  AppUtils.cityblur(),
                  Align(
                      alignment: Alignment.center,
                      child: ContainerWithCircle(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _description(),
                                    SizedBox(height: _defaultPaddingMargin),
                                    _form(),
                                    SizedBox(height: _defaultPaddingMargin),
                                    _imageLayout(),
                                    SizedBox(height: _defaultPaddingMargin),
                                    AppUtils.submitButton(
                                        context,
                                        isCustomer
                                            ? S.of(context).signup_customer
                                            : S.of(context).signup_as_yalla,
                                        () {
                                      if (_isValidForm()) {
                                        FocusScope.of(context).unfocus();
                                        _doRegister(scaffoldContext, context);
                                      }
                                    }),
//                                    _facebookButton(),
                                  ])),
                          childBgColor: Colors.white,
                          imageProvider: AssetImage(
                            'assets/images/logo_circle.png',
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
                ]))));
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

  /*Widget _facebookButton() {
    return InkWell(
        onTap: () {
          _fbLogin();
        },
        child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: _defaultPaddingMargin),
            child: Row(children: <Widget>[
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
                  ))
            ])));
  }*/

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
          isCustomer
              ? S.of(context).signup_customer
              : S.of(context).signup_business_owner,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xffB0B0B0),
              fontWeight: FontWeight.bold,
              fontSize: 20)),
      SizedBox(height: 5),
      Text(
          isCustomer
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
            onSaved: (input) => _con.user.name = input,
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
      visible: !isCustomer,
      child: Container(
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: AppColors.darkGreyColor, width: 1.0))),
          child: TextFormField(
              style: TextStyle(color: Theme.of(context).primaryColor),
              controller: !isCustomer ? _companyNameController : null,
              onSaved: (input) => _con.user.business_name = input,
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
            style: TextStyle(color: Theme.of(context).primaryColor),
            controller: _emailController,
            onSaved: (input) => _con.user.email = input,
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
            style: TextStyle(color: Theme.of(context).primaryColor),
            maxLength: Constants.PHONE_LENGTH,
            controller: _phoneController,
            onSaved: (input) => _con.user.phone_no =
                '${Constants.defaultPhoneCode}$codeDropdownValue$input',
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
            style: TextStyle(color: Theme.of(context).primaryColor),
            controller: _passController,
            onSaved: (input) {
              _con.user.password = input;
              _con.user.password_confirmation = input;
            },
            textAlignVertical: TextAlignVertical.center,
            obscureText: true,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.lock, size: 20),
                hintText: S.of(context).create_password,
                hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                border: InputBorder.none)));
  }

  bool _isValidForm() {
    if (!isCustomer && _companyNameController.text.isEmpty) {
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
        _phoneController.text.length < Constants.PHONE_LENGTH) {
      AppUtils.showMessage(
          context, S.of(context).error, S.of(context).should_be_a_valid_number);
      return false;
    } else if (_passController.text.isEmpty ||
        _passController.text.length < 3) {
      AppUtils.showMessage(context, S.of(context).error,
          S.of(context).should_be_more_than_3_characters);
      return false;
    } else if (!isCustomer && profilePic == null) {
      AppUtils.showMessage(context, S.of(context).error,
          '${S.of(context).capture} ${S.of(context).profile_pic} ${S.of(context).picture}');
      return false;
    } else if (!isCustomer && idCardFront == null) {
      AppUtils.showMessage(context, S.of(context).error,
          '${S.of(context).capture} ${S.of(context).id_front_pic} ${S.of(context).picture}');
      return false;
    } else if (!isCustomer && idCardBack == null) {
      AppUtils.showMessage(context, S.of(context).error,
          '${S.of(context).capture} ${S.of(context).id_back_pic} ${S.of(context).picture}');
      return false;
    }
    return true;
  }

  void _doRegister(BuildContext scaffoldContext, BuildContext buildContext) {
    AppUtils.onLoading(buildContext);
    List<UploadImageObject> pickedFiles = List();
    if (profilePic!=null && profilePic.path != null && profilePic.path.isNotEmpty) {
      pickedFiles.add(UploadImageObject(
          'profile_pic', profilePic.path, 'profile_pic.jpeg'));
    }
    if (!isCustomer) {
      pickedFiles.add(
          UploadImageObject('id_front', idCardFront.path, 'id_front.jpeg'));
      pickedFiles
          .add(UploadImageObject('id_back', idCardBack.path, 'id_back.jpeg'));
    }
    //    _con.register(onUserRegister: (User value) {
    _con.registerForm(pickedFiles, onUserRegister: (User value) {
      Navigator.pop(context);
      if (value != null && value.auth_token != null) {
        Scaffold.of(scaffoldContext).showSnackBar(
            SnackBar(content: Text(S.of(buildContext).welcome + value.name)));
        if (isCustomer)
          Navigator.of(buildContext).pushReplacementNamed(RouteGenerator.MAIN);
        else
          Navigator.of(buildContext)
              .pushReplacementNamed(RouteGenerator.PROVIDER_MAIN);
      } else if (value.status == Constants.STATUS_INVALID) {
        AppUtils.showMessage(context, S.of(context).error,
            S.of(buildContext).wrong_email_or_password);
      } else if (value.status == Constants.STATUS_APPROVAL) {
        AppUtils.showMessage(
            context, S.of(context).app_name, S.of(buildContext).not_approved,
            callback: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      } else {
        AppUtils.showMessage(
            context, S.of(context).error, S.of(buildContext).unavailable);
      }
    });
  }

  void _showSnackBar(BuildContext scaffoldContext, String message) {
    Scaffold.of(scaffoldContext).showSnackBar(SnackBar(content: Text(message)));
  }

  /*FacebookLogin facebookSignIn = FacebookLogin();

  Future<Null> _fbLogin() async {
    facebookSignIn.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    facebookSignIn.logIn(['email']).then((result) {
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          http
              .get('https://graph.facebook.com/v2.12/me?'
                  'fields=name,first_name,picture,last_name,'
                  'email&access_token=${accessToken.token}')
              .then((graphResponse) {
            print(graphResponse.body);
            FacebookUser facebookUser =
                FacebookUser.fromJson(json.decode(graphResponse.body));
            _con.user.email = facebookUser.email;
            AppUtils.onLoading(context);
            _con.exists(UserExistRequest(facebookUser.email),
                onUserExits: (userExists) {
              Navigator.of(context).pop();
              if (userExists) {
                AppUtils.showMessage(context, S.of(context).error,
                    S.of(context).user_already_exists);
              } else {
                setState(() {
                  _emailController.text = facebookUser.email;
                  _nameController.text = facebookUser.name;
                });
              }
            });
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
  }*/

  Widget _imageLayout() {
    return Container(
        padding: EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: isCustomer ? MainAxisSize.min : MainAxisSize.max,
            children: [
              ImagePickerExamplePage(
                  imageTitle: S.of(context).profile_pic,
                  callback: (PickedFile file) {
                    profilePic = file;
                  }),
              Visibility(
                  visible: !isCustomer,
                  child: ImagePickerExamplePage(
                      imageTitle: S.of(context).id_front_pic,
                      callback: (PickedFile file) {
                        idCardFront = file;
                      })),
              Visibility(
                  visible: !isCustomer,
                  child: ImagePickerExamplePage(
                      imageTitle: S.of(context).id_back_pic,
                      callback: (PickedFile file) {
                        idCardBack = file;
                      }))
            ]));
  }
}

class SignUpPageParam {
  SignUpPageParam({this.isCustomer, this.name, this.email});

  final bool isCustomer;
  final String name;
  final String email;
}

class UploadImageObject {
  String fieldName;
  String path;
  String imageName;

  UploadImageObject(this.fieldName, this.path, this.imageName);

  @override
  String toString() {
    return 'UploadImageObject{fieldName: $fieldName, path: $path, imageName: $imageName}';
  }
}
