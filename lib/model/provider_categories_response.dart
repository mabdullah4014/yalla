/// code : 200
/// data : [{"id":2,"name":"Carpet Furniture Wash"}]
/// message : ""

class ProviderCategoriesResponse {
  int code;
  List<ProviderCategory> data;
  String message;
  int status = 200;



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

}

/// id : 2
/// name : "Carpet Furniture Wash"

class ProviderCategory {
  int id;
  String name;
  String image_path;
  String description;
  bool isSelected = false;

  ProviderCategory(this.id);

  ProviderCategory.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    name = json["image_path"];
    name = json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["image_path"] = image_path;
    map["description"] = description;
    return map;
  }

}
