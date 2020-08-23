import 'package:arbi/ui/home.dart';
import 'package:arbi/ui/login.dart';
import 'package:arbi/ui/map_place_picker.dart';
import 'package:arbi/ui/provider/jobs_listing.dart';
import 'package:arbi/ui/provider/provider_profile.dart';
import 'package:arbi/ui/provider/provider_information.dart';
import 'package:arbi/ui/select_signup.dart';
import 'package:arbi/ui/service_buy.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/ui/service_target.dart';
import 'package:arbi/ui/signup.dart';
import 'package:arbi/ui/splash.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String SPLASH = '/Splash';
  static const String MAIN = '/Main';
  static const String LOGIN = '/Login';
  static const String SIGNUP = '/Signup';
  static const String SIGNUP_AS = '/SignupAs';
  static const String DETAIL = '/Detail';
  static const String TARGET = '/Target';
  static const String MAP = '/Map';
  static const String JOBS = '/Jobs';
  static const String PROFILE_PROVIDER = '/ProfileProvider';
  static const String PROVIDER_COMPLETE_SIGNUP = '/ProviderSignUpComplete';
  static const String BUY = '/Buy';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case MAIN:
        return MaterialPageRoute(builder: (_) => HomePageScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case SIGNUP:
        return MaterialPageRoute(
            builder: (_) => SignUpPage(signUpPageParam: args));
      case SIGNUP_AS:
        return MaterialPageRoute(
            builder: (_) => SelectSignUpPage(signUpPageParam: args));
      case DETAIL:
        return MaterialPageRoute(
            builder: (_) =>
                ServiceDetailPage(params: args as ServiceDetailPageParam));
      case TARGET:
        return MaterialPageRoute(
            builder: (_) =>
                ServiceTargetPage(params: args as ServiceTargetPageParam));
      case MAP:
        return MaterialPageRoute(builder: (_) => MapPlacePicker());
      case JOBS:
        return MaterialPageRoute(builder: (_) => JobsListingPage());
      case PROFILE_PROVIDER:
        return MaterialPageRoute(builder: (_) => ProviderProfilePage());
      case PROVIDER_COMPLETE_SIGNUP:
        return MaterialPageRoute(builder: (_) => ProviderCompleteSignupPage());
      case BUY:
        return MaterialPageRoute(
            builder: (_) =>
                ServiceBuyPage(params: args as ServiceBuyPageParam));
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
