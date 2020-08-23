/// code : 200
/// data : [{"id":2,"name":"Carpet Furniture Wash"}]
/// message : ""

class ProviderCategoriesResponse {
  int code;
  List<ProviderCategory> data;
  String message;
  int status = 200;

  static const int STATUS_INVALID = 401;
  static const int STATUS_SOMETHING_WENT_WRONG = 500;

  ProviderCategoriesResponse.status(int status) {
    this.status = status;
  }

  ProviderCategoriesResponse.fromJson(dynamic json) {
    code = json["code"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(ProviderCategory.fromJson(v));
      });
    }
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = code;
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    return map;
  }

  List<dynamic> getDataMap() {
    var list = [];
    for (ProviderCategory providerCategory in data) {
      list.add(providerCategory.toJson());
    }
    return list;
  }
}

/// id : 2
/// name : "Carpet Furniture Wash"

class ProviderCategory {
  int id;
  String name;

  ProviderCategory.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id.toString();
    map["name"] = name;
    return map;
  }
}
