//import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/utils/pref_util.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

//import 'firebase/notification_handler.dart';
import 'generated/l10n.dart';
import 'route_generator.dart';
import 'settings_controller.dart';
import 'utils/app_config.dart' as config;
import 'model/setting.dart';
import 'repo/settings_repository.dart' as settingRepo;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  runApp(MyApp());
}

class MyApp extends AppMVC {
  // This widget is the root of your application.
//  /// Supply 'the Controller' for this application.
  MyApp({Key key}) : super(con: SettingsController(), key: key);

//  FirebaseMessaging _firebaseMessaging;

  @override
  void initApp() {
    super.initApp();
    PreferenceUtils.init();
//    _firebaseMessaging = FirebaseMessaging();
//    _firebaseMessaging.requestNotificationPermissions();
//    _firebaseMessaging.getToken().then((String _deviceToken) {
//      print('Yalla token: $_deviceToken');
//      PreferenceUtils.setString(PreferenceUtils.push_token, _deviceToken);
//      currentUser.value.push_notification_token = _deviceToken;
//    });
//
//    _firebaseMessaging.configure(
//        onMessage: (Map<String, dynamic> message) async {
//          print("onMessage: $message");
////        _showItemDialog(message);
//        },
//        onBackgroundMessage: myBackgroundMessageHandler,
//        onLaunch: (Map<String, dynamic> message) async {
//          print("onLaunch: $message");
////        _navigateToItemDetail(message);
//        },
//        onResume: (Map<String, dynamic> message) async {
//          print("onResume: $message");
////        _navigateToItemDetail(message);
//        });
  }

  @override
  Widget build(BuildContext buildContext) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) {
          if (brightness == Brightness.light) {
            return ThemeData(
                fontFamily: 'Roboto',
                primaryColor: config.ApplicationColors().mainColor(1),
                brightness: brightness,
                accentColor: config.ApplicationColors().mainColor(1),
                focusColor: config.ApplicationColors().accentColor(1),
                hintColor: config.ApplicationColors().secondColor(1),
                textTheme: TextTheme(
                    headline5: TextStyle(
                        fontSize: 20.0,
                        color: config.ApplicationColors().secondColor(1)),
                    headline4: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: config.ApplicationColors().secondColor(1)),
                    headline3: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: config.ApplicationColors().secondColor(1)),
                    headline2: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        color: config.ApplicationColors().mainColor(1)),
                    headline1: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w300,
                        color: config.ApplicationColors().secondColor(1)),
                    subtitle1: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: config.ApplicationColors().secondColor(1)),
                    headline6: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: config.ApplicationColors().mainColor(1)),
                    bodyText2: TextStyle(
                        fontSize: 12.0,
                        color: config.ApplicationColors().secondColor(1)),
                    bodyText1: TextStyle(
                        fontSize: 14.0,
                        color: config.ApplicationColors().secondColor(1)),
                    caption: TextStyle(
                        fontSize: 12.0,
                        color: config.ApplicationColors().accentColor(1))));
          } else {
            return ThemeData(
                fontFamily: 'Roboto',
                primaryColor: Color(0xFF252525),
                brightness: Brightness.dark,
                scaffoldBackgroundColor: Color(0xFF2C2C2C),
                accentColor: config.ApplicationColors().mainDarkColor(1),
                hintColor: config.ApplicationColors().secondDarkColor(1),
                focusColor: config.ApplicationColors().accentDarkColor(1),
                textTheme: TextTheme(
                    headline5: TextStyle(
                        fontSize: 20.0,
                        color: config.ApplicationColors().secondDarkColor(1)),
                    headline4: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: config.ApplicationColors().secondDarkColor(1)),
                    headline3: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: config.ApplicationColors().secondDarkColor(1)),
                    headline2: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        color: config.ApplicationColors().mainDarkColor(1)),
                    headline1: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w300,
                        color: config.ApplicationColors().secondDarkColor(1)),
                    subtitle1: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: config.ApplicationColors().secondDarkColor(1)),
                    headline6: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: config.ApplicationColors().mainDarkColor(1)),
                    bodyText2: TextStyle(
                        fontSize: 12.0,
                        color: config.ApplicationColors().secondDarkColor(1)),
                    bodyText1: TextStyle(
                        fontSize: 14.0,
                        color: config.ApplicationColors().secondDarkColor(1)),
                    caption: TextStyle(
                        fontSize: 12.0,
                        color:
                            config.ApplicationColors().secondDarkColor(0.6))));
          }
        },
        themedWidgetBuilder: (context, theme) {
          return ValueListenableBuilder(
              valueListenable: settingRepo.setting,
              builder: (context, Setting _setting, _) {
                return MaterialApp(
                    title: 'Yalla',
                    initialRoute: RouteGenerator.SPLASH,
                    onGenerateRoute: RouteGenerator.generateRoute,
                    debugShowCheckedModeBanner: true,
                    locale: _setting.mobileLanguage.value,
                    localizationsDelegates: [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    theme: theme);
              });
        });
  }
}
