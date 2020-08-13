
class User {
  String id;
  String name;
  String email;
  String password;
  String apiToken;
  String deviceToken;
  String phone;
  String address;
  String bio;
  String companyName;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    name = jsonMap['name'];
    companyName = jsonMap['company_name'];
    email = jsonMap['email'];
    apiToken = jsonMap['api_token'];
    deviceToken = jsonMap['device_token'];
    try {
      phone = jsonMap['custom_fields']['phone']['view'];
    } catch (e) {
      phone = "";
    }
    try {
      address = jsonMap['custom_fields']['address']['view'];
    } catch (e) {
      address = "";
    }
    try {
      bio = jsonMap['custom_fields']['bio']['view'];
    } catch (e) {
      bio = "";
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["company_name"] = companyName;
    map["password"] = password;
    map["api_token"] = apiToken;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    map["phone"] = phone;
    map["address"] = address;
    map["bio"] = bio;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
