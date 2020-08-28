/// status_code : 200
/// price : 12500
/// message : ""

class PlaceOrderResponse {
  int status_code;
  double price;
  String message;
  int status = 200;


  PlaceOrderResponse.status(int status) {
    this.status = status;
  }

  PlaceOrderResponse({int statusCode, double price, String message}) {
    status_code = statusCode;
    price = price;
    message = message;
  }

  PlaceOrderResponse.fromJson(dynamic json) {
    status_code = json["status_code"];
    message = json["message"];
    if (json['price'] != null) this.price = json["price"].toDouble();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = status_code;
    map["price"] = price;
    map["message"] = message;
    return map;
  }


}
