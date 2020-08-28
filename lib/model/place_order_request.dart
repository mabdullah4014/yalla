/// status_code : 200
/// price : 12500
/// message : ""

class PlaceOrderRequest {
  int category_id;
  List<int> cat_values;
  Map<String, String> target;
  String price;
  String notes;
  int user_id;
  String latitude;
  String longitude;

  PlaceOrderRequest({this.category_id, this.cat_values, this.target, this.price,
      this.notes, this.user_id});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category_id"] = this.category_id;
    map["price"] = this.price;
    map["notes"] = this.notes;
    map["user_id"] = this.user_id;
    map["latitude"] = this.latitude;
    map["longitude"] = this.longitude;
    if (cat_values != null) {
      map["cat_values"] = cat_values;
    }
    if (target != null) {
      map["target"] = target;
    }
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
