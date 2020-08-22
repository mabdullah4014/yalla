/// status_code : 200
/// price : 12500
/// message : ""

class CheckServiceRequest {
  int cat_id;
  List<int> cat_values;
  Map<String, String> target;


  CheckServiceRequest(this.cat_id, this.cat_values, this.target);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["cat_id"] = this.cat_id;
    if (cat_values != null) {
      map["cat_values"] = cat_values;
    }
    if (target != null) {
      map["target"] = target;
    }
    return map;
  }
}
