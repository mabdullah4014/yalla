// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Yalla`
  String get app_name {
    return Intl.message(
      'Yalla',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Blog`
  String get blog {
    return Intl.message(
      'Blog',
      name: 'blog',
      desc: '',
      args: [],
    );
  }

  /// `How it works?`
  String get how_it_works {
    return Intl.message(
      'How it works?',
      name: 'how_it_works',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get terms_and_condition {
    return Intl.message(
      'Terms & Conditions',
      name: 'terms_and_condition',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account ?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account ?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account ?`
  String get already_account {
    return Intl.message(
      'Already have an account ?',
      name: 'already_account',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get email_address {
    return Intl.message(
      'Email address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Log in with Facebook`
  String get login_fb {
    return Intl.message(
      'Log in with Facebook',
      name: 'login_fb',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password ?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password ?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Wrong email or password`
  String get wrong_email_or_password {
    return Intl.message(
      'Wrong email or password',
      name: 'wrong_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Welcome `
  String get welcome {
    return Intl.message(
      'Welcome ',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Email should be valid`
  String get should_be_a_valid_email {
    return Intl.message(
      'Email should be valid',
      name: 'should_be_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password should be more than 3 characters`
  String get should_be_more_than_3_characters {
    return Intl.message(
      'Password should be more than 3 characters',
      name: 'should_be_more_than_3_characters',
      desc: '',
      args: [],
    );
  }

  /// `Sign up as a customer`
  String get signup_customer {
    return Intl.message(
      'Sign up as a customer',
      name: 'signup_customer',
      desc: '',
      args: [],
    );
  }

  /// `Sign up and post a job or project and get contacted by Yalla`
  String get signup_customer_desc {
    return Intl.message(
      'Sign up and post a job or project and get contacted by Yalla',
      name: 'signup_customer_desc',
      desc: '',
      args: [],
    );
  }

  /// `Enter full name`
  String get should_be_a_valid_name {
    return Intl.message(
      'Enter full name',
      name: 'should_be_a_valid_name',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid phone number`
  String get should_be_a_valid_number {
    return Intl.message(
      'Enter valid phone number',
      name: 'should_be_a_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number`
  String get mobile_number {
    return Intl.message(
      'Mobile number',
      name: 'mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Create a password`
  String get create_password {
    return Intl.message(
      'Create a password',
      name: 'create_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign up as a Business owner`
  String get signup_business_owner {
    return Intl.message(
      'Sign up as a Business owner',
      name: 'signup_business_owner',
      desc: '',
      args: [],
    );
  }

  /// `Sign up and add your business`
  String get signup_business_desc {
    return Intl.message(
      'Sign up and add your business',
      name: 'signup_business_desc',
      desc: '',
      args: [],
    );
  }

  /// `Yalla/Company name`
  String get comapny_name {
    return Intl.message(
      'Yalla/Company name',
      name: 'comapny_name',
      desc: '',
      args: [],
    );
  }

  /// `Sign up as Yalla`
  String get signup_as_yalla {
    return Intl.message(
      'Sign up as Yalla',
      name: 'signup_as_yalla',
      desc: '',
      args: [],
    );
  }

  /// `By signing up, I agree to yalla's`
  String get sign_up_agree {
    return Intl.message(
      'By signing up, I agree to yalla\'s',
      name: 'sign_up_agree',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Facebook`
  String get sign_up_fb {
    return Intl.message(
      'Sign up with Facebook',
      name: 'sign_up_fb',
      desc: '',
      args: [],
    );
  }

  /// `Choose your account type`
  String get choose_account_type {
    return Intl.message(
      'Choose your account type',
      name: 'choose_account_type',
      desc: '',
      args: [],
    );
  }

  /// `Looking for service?`
  String get looking_for_service {
    return Intl.message(
      'Looking for service?',
      name: 'looking_for_service',
      desc: '',
      args: [],
    );
  }

  /// `Are you as business owner?`
  String get are_business_owner {
    return Intl.message(
      'Are you as business owner?',
      name: 'are_business_owner',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid`
  String get enter_valid {
    return Intl.message(
      'Enter valid',
      name: 'enter_valid',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Tap map to pin point location`
  String get tap_for_location {
    return Intl.message(
      'Tap map to pin point location',
      name: 'tap_for_location',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Jobs`
  String get jobs {
    return Intl.message(
      'Jobs',
      name: 'jobs',
      desc: '',
      args: [],
    );
  }

  /// `No Jobs`
  String get no_jobs {
    return Intl.message(
      'No Jobs',
      name: 'no_jobs',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Business detail cannot be empty`
  String get business_detail_empty {
    return Intl.message(
      'Business detail cannot be empty',
      name: 'business_detail_empty',
      desc: '',
      args: [],
    );
  }

  /// `Business detail`
  String get business_detail {
    return Intl.message(
      'Business detail',
      name: 'business_detail',
      desc: '',
      args: [],
    );
  }

  /// `Account Information`
  String get account_information {
    return Intl.message(
      'Account Information',
      name: 'account_information',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Please choose one or more`
  String get please_select_more {
    return Intl.message(
      'Please choose one or more',
      name: 'please_select_more',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `category`
  String get category {
    return Intl.message(
      'category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Service unavailable at the moment. Please try again later`
  String get unavailable {
    return Intl.message(
      'Service unavailable at the moment. Please try again later',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `No categories available`
  String get no_categories {
    return Intl.message(
      'No categories available',
      name: 'no_categories',
      desc: '',
      args: [],
    );
  }

  /// `No banners available`
  String get no_banners {
    return Intl.message(
      'No banners available',
      name: 'no_banners',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Order`
  String get confirm_order {
    return Intl.message(
      'Confirm Order',
      name: 'confirm_order',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get place_order {
    return Intl.message(
      'Place Order',
      name: 'place_order',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid values to calculate price`
  String get price_zero {
    return Intl.message(
      'Enter valid values to calculate price',
      name: 'price_zero',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Calculating Price...`
  String get calculating_price {
    return Intl.message(
      'Calculating Price...',
      name: 'calculating_price',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message(
      'Service',
      name: 'service',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `User already exists`
  String get user_already_exists {
    return Intl.message(
      'User already exists',
      name: 'user_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logout_message {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logout_message',
      desc: '',
      args: [],
    );
  }

  /// `Login to continue..`
  String get login_to_continue {
    return Intl.message(
      'Login to continue..',
      name: 'login_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Enter location to proceed`
  String get enter_location {
    return Intl.message(
      'Enter location to proceed',
      name: 'enter_location',
      desc: '',
      args: [],
    );
  }

  /// `Order not placed`
  String get order_not_placed {
    return Intl.message(
      'Order not placed',
      name: 'order_not_placed',
      desc: '',
      args: [],
    );
  }

  /// `Order placed successfully`
  String get order_placed {
    return Intl.message(
      'Order placed successfully',
      name: 'order_placed',
      desc: '',
      args: [],
    );
  }

  /// `Updating...`
  String get updating {
    return Intl.message(
      'Updating...',
      name: 'updating',
      desc: '',
      args: [],
    );
  }

  /// `User updated successfully.`
  String get user_updated {
    return Intl.message(
      'User updated successfully.',
      name: 'user_updated',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get my_order {
    return Intl.message(
      'My Orders',
      name: 'my_order',
      desc: '',
      args: [],
    );
  }

  /// `Provider Name`
  String get provider_name {
    return Intl.message(
      'Provider Name',
      name: 'provider_name',
      desc: '',
      args: [],
    );
  }

  /// `My Jobs`
  String get my_jobs {
    return Intl.message(
      'My Jobs',
      name: 'my_jobs',
      desc: '',
      args: [],
    );
  }

  /// `Update Order`
  String get change_status {
    return Intl.message(
      'Update Order',
      name: 'change_status',
      desc: '',
      args: [],
    );
  }

  /// `Order updated successfully.`
  String get order_update {
    return Intl.message(
      'Order updated successfully.',
      name: 'order_update',
      desc: '',
      args: [],
    );
  }

  /// `Error updating order status.`
  String get order_update_error {
    return Intl.message(
      'Error updating order status.',
      name: 'order_update_error',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Available Jobs`
  String get available_jobs {
    return Intl.message(
      'Available Jobs',
      name: 'available_jobs',
      desc: '',
      args: [],
    );
  }

  /// `Tap to enter location`
  String get tap_to_enter {
    return Intl.message(
      'Tap to enter location',
      name: 'tap_to_enter',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Unable to proceed`
  String get unable_to_proceed {
    return Intl.message(
      'Unable to proceed',
      name: 'unable_to_proceed',
      desc: '',
      args: [],
    );
  }

  /// `Current categories`
  String get selected_categories {
    return Intl.message(
      'Current categories',
      name: 'selected_categories',
      desc: '',
      args: [],
    );
  }

  /// `Select at least one category to proceed`
  String get select_category_to_proceed {
    return Intl.message(
      'Select at least one category to proceed',
      name: 'select_category_to_proceed',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this image?`
  String get delete_image_message {
    return Intl.message(
      'Are you sure you want to delete this image?',
      name: 'delete_image_message',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Profile Pic`
  String get profile_pic {
    return Intl.message(
      'Profile Pic',
      name: 'profile_pic',
      desc: '',
      args: [],
    );
  }

  /// `ID Card Front`
  String get id_front_pic {
    return Intl.message(
      'ID Card Front',
      name: 'id_front_pic',
      desc: '',
      args: [],
    );
  }

  /// `ID Card Back`
  String get id_back_pic {
    return Intl.message(
      'ID Card Back',
      name: 'id_back_pic',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'ur'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}