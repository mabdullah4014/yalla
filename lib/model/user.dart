class User {
  String id;
  String name;
  String email;
  String password;
  String password_confirmation;
  String auth_token;
  String push_notification_token;
  String phone_no;
  String address;
  String bio;
  String business_name;
  String app_version;
  String device;
  String user_type;
  String latitude;
  String longitude;
  int status = 200;

  // used for indicate if client logged in or not
  bool auth;

  User();

  User.status(int status) {
    this.status = status;
  }

  User.fromJSON(Map<String, dynamic> jsonMap) {
    email = jsonMap['email'];
    password = jsonMap['password'];
    password_confirmation = jsonMap['password_confirmation'];
    push_notification_token = jsonMap['push_notification_token'];
    app_version = jsonMap['app_version'];
    device = jsonMap['device'];
    name = jsonMap['name'];
    id = jsonMap['id'].toString();
    business_name = jsonMap['company_name'];
    auth_token = jsonMap['auth_token'];
    phone_no = jsonMap['phone_no'];
    address = jsonMap['address'];
    bio = jsonMap['bio'];
    user_type = jsonMap['user_type'];
    latitude = jsonMap['latitude'];
    longitude = jsonMap['longitude'];
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map["email"] = email;
    map["password"] = password;
    map["password_confirmation"] = password_confirmation;
    map["push_notification_token"] = push_notification_token;
    map["app_version"] = app_version;
    map["device"] = device;
    map["name"] = name;
    map["id"] = id;
    map["company_name"] = business_name;
    map["auth_token"] = auth_token;
    map["phone_no"] = phone_no;
    map["address"] = address;
    map["bio"] = bio;
    map["user_type"] = user_type;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    return map;
  }

  @override
  String toString() {
    var map = this.toJson();
    map["auth"] = this.auth;
    return map.toString();
  }

  bool hasAuthToken() {
    return auth_token != null && auth_token.isNotEmpty;
  }

  String location() {
    if (latitude != null &&
        latitude.isNotEmpty &&
        longitude != null &&
        longitude.isNotEmpty) {
      return '$latitude,$longitude';
    }
    return '';
  }

  static const String CUSTOMER = 'customer';
  static const String SERVICE_PROVIDER = 'service_provider';

  static const int STATUS_INVALID = 401;
  static const int STATUS_SOMETHING_WENT_WRONG = 500;
}
