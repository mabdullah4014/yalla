/// status_code : 200
/// price : 12500
/// message : ""

class UserExistRequest {

  String email;

  UserExistRequest(this.email);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = this.email;
    return map;
  }
}
