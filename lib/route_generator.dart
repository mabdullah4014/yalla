import 'package:arbi/ui/app_detail.dart';
import 'package:arbi/ui/change_language.dart';
import 'package:arbi/ui/customer_order_listing.dart';
import 'package:arbi/ui/home.dart';
import 'package:arbi/ui/image_picker_example.dart';
import 'package:arbi/ui/login.dart';
import 'package:arbi/ui/map_place_picker.dart';
import 'package:arbi/ui/provider/provider_home.dart';
import 'package:arbi/ui/provider/provider_job_detail.dart';
import 'package:arbi/ui/provider/provider_jobs_listing.dart';
import 'package:arbi/ui/provider/provider_profile.dart';
import 'package:arbi/ui/select_signup.dart';
import 'package:arbi/ui/service_buy.dart';
import 'package:arbi/ui/service_detail.dart';
import 'package:arbi/ui/service_target.dart';
import 'package:arbi/ui/signup.dart';
import 'package:arbi/ui/splash.dart';
import 'package:flutter/material.dart';

import 'model/customer_order_response.dart';

class RouteGenerator {
  static const String SPLASH = '/Splash';
  static const String MAIN = '/Main';
  static const String LOGIN = '/Login';
  static const String SIGNUP = '/Signup';
  static const String SIGNUP_AS = '/SignupAs';
  static const String DETAIL = '/Detail';
  static const String TARGET = '/Target';
  static const String MAP = '/Map';
  static const String PROVIDER_JOBS = '/Jobs';
  static const String PROFILE_PROVIDER = '/ProfileProvider';
  static const String BUY = '/Buy';
  static const String PROVIDER_MAIN = '/ProviderMain';
  static const String CUSTOMER_ORDER = '/CustomerOrders';
  static const String LANGUAGE = '/Language';
  static const String IMAGE = '/Image';
  static const String PROVIDER_JOB_DETAIL = '/ProviderJobDetail';
  static const String APP_DETAIL = '/AppDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case MAIN:
        return MaterialPageRoute(builder: (_) => HomePageScreen());
      case LOGIN:
        return MaterialPageRoute(
            builder: (_) => LoginPage(loginPageParam: args as LoginPageParam));
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
      case PROVIDER_JOBS:
        return MaterialPageRoute(builder: (_) => ProviderJobsListingPage());
      case PROFILE_PROVIDER:
        return MaterialPageRoute(builder: (_) => ProviderProfilePage());
      case BUY:
        return MaterialPageRoute(
            builder: (_) =>
                ServiceBuyPage(params: args as ServiceBuyPageParam));
      case PROVIDER_MAIN:
        return MaterialPageRoute(builder: (_) => ProviderHomePageScreen());
      case CUSTOMER_ORDER:
        return MaterialPageRoute(builder: (_) => CustomerOrderListingPage());
      case LANGUAGE:
        return MaterialPageRoute(builder: (_) => ChangeLanguageWidget());
      case IMAGE:
        return MaterialPageRoute(builder: (_) => ImagePickerExamplePage());
      case PROVIDER_JOB_DETAIL:
        return MaterialPageRoute(
            builder: (_) => ProviderJobDetailPage(order: args as Order));
      case APP_DETAIL:
        return MaterialPageRoute(
            builder: (_) =>
                AppDetailPage(appDetailObject: args as AppDetailObject));
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
