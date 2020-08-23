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
    if (email != null && email.isNotEmpty) map["email"] = email;
    if (password != null && password.isNotEmpty) map["password"] = password;
    if (password_confirmation != null && password_confirmation.isNotEmpty)
      map["password_confirmation"] = password_confirmation;
    if (push_notification_token != null && push_notification_token.isNotEmpty)
      map["push_notification_token"] = push_notification_token;
    if (app_version != null && app_version.isNotEmpty)
      map["app_version"] = app_version;
    if (device != null && device.isNotEmpty) map["device"] = device;
    if (name != null && name.isNotEmpty) map["name"] = name;
    if (id != null && id.isNotEmpty) map["id"] = id;
    if (business_name != null && business_name.isNotEmpty)
      map["company_name"] = business_name;
    if (auth_token != null && auth_token.isNotEmpty)
      map["auth_token"] = auth_token;
    if (phone_no != null && phone_no.isNotEmpty) map["phone_no"] = phone_no;
    if (address != null && address.isNotEmpty) map["address"] = address;
    if (bio != null && bio.isNotEmpty) map["bio"] = bio;
    if (user_type != null && user_type.isNotEmpty) map["user_type"] = user_type;
    if (latitude != null && latitude.isNotEmpty) map["latitude"] = latitude;
    if (longitude != null && longitude.isNotEmpty) map["longitude"] = longitude;
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
