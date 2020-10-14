import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/repo/settings_repository.dart' as settingsRepo;
import 'package:arbi/route_generator.dart';
import 'package:arbi/ui/login.dart';
import 'package:arbi/utils/app_colors.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/user_controller.dart' as userCont;
import 'app_detail.dart';

class CustomerDrawerWidget extends StatelessWidget {
  CustomerDrawerWidget({Key key}) : super(key: key);

  static const _DrawerItemColor = Color(0xff8B8B8B);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      Expanded(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        InkWell(
            child: DrawerHeader(
                child: Image.asset(
                  'assets/images/logo_text.png',
                  fit: BoxFit.contain,
                ),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(color: AppColors.greyColor))),
        Visibility(
            visible: userCont.currentUser.value.auth,
            child: ListTile(
                title: Text(
                  S.of(context).my_order,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RouteGenerator.CUSTOMER_ORDER);
                })),
        ListTile(
            title: Text(
              S.of(context).about,
              style: TextStyle(color: _DrawerItemColor),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RouteGenerator.APP_DETAIL,
                  arguments: AppDetailObject(
                      text: settingsRepo.setting.value.about,
                      title: S.of(context).about));
            }),
        ListTile(
            title: Text(S.of(context).how_it_works,
                style: TextStyle(color: _DrawerItemColor)),
            onTap: () {
              Navigator.of(context).pushNamed(RouteGenerator.APP_DETAIL,
                  arguments: AppDetailObject(
                      text: settingsRepo.setting.value.how_it_works,
                      title: S.of(context).how_it_works));
            }),
        ListTile(
            title: Text(S.of(context).terms_and_condition,
                style: TextStyle(color: _DrawerItemColor)),
            onTap: () {
              Navigator.of(context).pushNamed(RouteGenerator.APP_DETAIL,
                  arguments: AppDetailObject(
                      text: settingsRepo.setting.value.terms_and_conditions,
                      title: S.of(context).terms_and_condition));
            }),
        ListTile(
            title: Text(S.of(context).change_language,
                style: TextStyle(color: _DrawerItemColor)),
            onTap: () {
              Navigator.of(context).pushNamed(RouteGenerator.LANGUAGE);
            }),
        ListTile(
            title: Text(S.of(context).contact_us,
                style: TextStyle(color: _DrawerItemColor)),
            onTap: () {
              Navigator.of(context).pushNamed(RouteGenerator.APP_DETAIL,
                  arguments: AppDetailObject(
                      text: settingsRepo.setting.value.contact_us,
                      title: S.of(context).contact_us));
            }),
        Row(children: <Widget>[
          Flexible(
              fit: FlexFit.tight,
              child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook,
                      color: _DrawerItemColor),
                  onPressed: () {
                    launch(settingsRepo.setting.value.fb);
                  }),
              flex: 1),
          Flexible(
              fit: FlexFit.tight,
              child: IconButton(
                  icon:
                      FaIcon(FontAwesomeIcons.twitter, color: _DrawerItemColor),
                  onPressed: () {
                    launch(settingsRepo.setting.value.twitter);
                  }),
              flex: 1),
          Flexible(
              fit: FlexFit.tight,
              child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram,
                      color: _DrawerItemColor),
                  onPressed: () {
                    launch(settingsRepo.setting.value.insta);
                  }),
              flex: 1)
        ])
      ])),
      Visibility(
          visible: !userCont.currentUser.value.auth,
          child: Container(
              color: AppColors.greyColor,
              // This align moves the children to the bottom
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  // This container holds all the children that will be aligned
                  // on the bottom and should not scroll with the above ListView
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RouteGenerator.LOGIN,
                                arguments: LoginPageParam(
                                    comingFrom: LoginPage.FROM_DRAWER));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(S.of(context).login.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    color: _DrawerItemColor)),
                          ),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RouteGenerator.SIGNUP_AS);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(S.of(context).signup.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6),
                          ),
                        ),
                        flex: 1,
                      )
                    ],
                  )))),
      Visibility(
          visible: userCont.currentUser.value.auth,
          child: Container(
              color: AppColors.greyColor,
              // This align moves the children to the bottom
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  // This container holds all the children that will be aligned
                  // on the bottom and should not scroll with the above ListView
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: InkWell(
                          onTap: () {
                            AppUtils.yesNoDialog(context, S.of(context).logout,
                                S.of(context).logout_message, () {
                              currentUser.value.logout();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouteGenerator.LOGIN,
                                  (Route<dynamic> route) => false,
                                  arguments: LoginPageParam(
                                      comingFrom: LoginPage.FROM_SPLASH));
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(S.of(context).logout.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    color: _DrawerItemColor)),
                          ),
                        ),
                        flex: 1,
                      )
                    ],
                  ))))
    ]));
  }
}
