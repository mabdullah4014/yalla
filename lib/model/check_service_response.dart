/// status_code : 200
/// price : 12500
/// message : ""

class CheckServiceResponse {
  int status_code;
  double price;
  double distance;
  String message;
  int status = 200;
  Map<String, String> target;

  CheckServiceResponse.status(int status) {
    this.status = status;
  }

  CheckServiceResponse({int statusCode, double price, String message}) {
    status_code = statusCode;
    price = price;
    message = message;
  }

  CheckServiceResponse.fromJson(dynamic json) {
    status_code = json["status_code"];
    message = json["message"];
    if (json['price'] != null) this.price = json["price"].toDouble();
    if (json['distance'] != null) this.distance = json["distance"].toDouble();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = status_code;
    map["price"] = price;
    map["distance"] = distance;
    map["message"] = message;
    return map;
  }

}
