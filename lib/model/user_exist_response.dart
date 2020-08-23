//{
//"success": 200,
//"data": false,
//"message": ""
//}
class UserExistResponse {
  int success;
  bool data;
  String message;
  int status = 200;

  UserExistResponse.status(int status) {
    this.status = status;
  }

  UserExistResponse({int statusCode, bool data, String message}) {
    success = statusCode;
    this.data = data;
    this.message = message;
  }

  UserExistResponse.fromJson(dynamic json) {
    success = json["success"];
    message = json["message"];
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    map["data"] = data;
    map["message"] = message;
    return map;
  }

  static const int STATUS_INVALID = 401;
  static const int STATUS_SOMETHING_WENT_WRONG = 500;
}
