import 'package:arbi/generated/l10n.dart';
import 'package:arbi/route_generator.dart';
import 'package:arbi/utils/colors.dart';
import 'package:arbi/utils/route_argument.dart';
import 'package:arbi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key key}) : super(key: key);

  static const _DrawerItemColor = Color(0xff8B8B8B);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      Expanded(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(
                color: AppColors.greyColor,
              ),
            ),
            ListTile(
              title: Text(
                S.of(context).about,
                style: TextStyle(color: _DrawerItemColor),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(S.of(context).blog,
                  style: TextStyle(color: _DrawerItemColor)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(S.of(context).how_it_works,
                  style: TextStyle(color: _DrawerItemColor)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(S.of(context).terms_and_condition,
                  style: TextStyle(color: _DrawerItemColor)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebook,
                          color: _DrawerItemColor),
                      onPressed: () {}),
                  flex: 1,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.twitter,
                          color: _DrawerItemColor),
                      onPressed: () {}),
                  flex: 1,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.instagram,
                          color: _DrawerItemColor),
                      onPressed: () {}),
                  flex: 1,
                )
              ],
            ),
          ],
        ),
      ),
      Container(
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
                        Navigator.of(context).pushNamed(RouteGenerator.LOGIN);
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
              )))
    ]));
  }
}
