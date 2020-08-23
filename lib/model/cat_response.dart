/// code : 200
/// data : {"values":[{"id":23,"name":"Empty House 35000","image":"","description":"","view_type":"grid","values":null,"fixed_price":"","tar":[{"type":"input","default_value":"","is_enabled":true,"label":"My label","tar_value":"label1"},{"type":"checkbox","default_value":"","is_enabled":true,"label":"This is my checkbox","tar_value":"checkbox_1"},{"type":"location","default_value":"","is_enabled":true,"label":"Start Location","tar_value":"start_location"},{"type":"location","default_value":"","is_enabled":true,"label":"End Location","tar_value":"end_location"}]}],"banners":[]}
/// message : ""

class CatResponse {
  int status = 200;
  int code;
  Data data;
  String message;

  CatResponse.status(int status) {
    this.status = status;
  }

  CatResponse({int code, Data data, String message}) {
    this.code = code;
    this.data = data;
    this.message = message;
  }

  CatResponse.fromJson(dynamic json) {
    code = json["code"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = code;
    if (data != null) {
      map["data"] = data.toJson();
    }
    map["message"] = message;
    return map;
  }

  static const int STATUS_INVALID = 401;
  static const int STATUS_SOMETHING_WENT_WRONG = 500;
}

/// values : [{"id":23,"name":"Empty House 35000","image":"","description":"","view_type":"grid","values":null,"fixed_price":"","tar":[{"type":"input","default_value":"","is_enabled":true,"label":"My label","tar_value":"label1"},{"type":"checkbox","default_value":"","is_enabled":true,"label":"This is my checkbox","tar_value":"checkbox_1"},{"type":"location","default_value":"","is_enabled":true,"label":"Start Location","tar_value":"start_location"},{"type":"location","default_value":"","is_enabled":true,"label":"End Location","tar_value":"end_location"}]}]
/// banners : []

class Data {
  List<ServiceValue> values;
  List<Banner> banners;

  Data({List<ServiceValue> values, List<Banner> banners}) {
    this.values = values;
    this.banners = banners;
  }

  Data.fromJson(dynamic json) {
    if (json["values"] != null) {
      values = [];
      json["values"].forEach((v) {
        values.add(ServiceValue.fromJson(v));
      });
    }
    if (json["banners"] != null) {
      banners = [];
      json["banners"].forEach((v) {
        banners.add(Banner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (values != null) {
      map["values"] = values.map((v) => v.toJson()).toList();
    }
    if (banners != null) {
      map["banners"] = banners.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// category_id : 1
/// image_name : "1.jpg"
/// created_at : "2019-04-15 19:14:42"
/// updated_at : "2019-04-15 19:14:42"
/// service : {"id":1,"name":"Cleaning & Laundry","view_type":"list","fixed_price":0,"price":null,"description":null,"created_at":"2020-08-22 10:25:06","updated_at":"2020-08-22 10:25:06","deleted_at":null,"image_path":null}
/// path : "http://yella.dotdropit.com/storage/banner/1.jpg"

class Banner {
  int id;
  ServiceValue service;
  String path;

  Banner(
      {int id,
      String createdAt,
      String updatedAt,
      ServiceValue service,
      String path}) {
    this.id = id;
    this.service = service;
    this.path = path;
  }

  Banner.fromJson(dynamic json) {
    this.id = json["id"];
    this.service =
        json["service"] != null ? ServiceValue.fromJson(json["service"]) : null;
    this.path = json["path"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = this.id;
    if (this.service != null) {
      map["service"] = this.service.toJson();
    }
    map["path"] = this.path;
    return map;
  }
}

/// id : 23
/// name : "Empty House 35000"
/// image : ""
/// description : ""
/// view_type : "grid"
/// values : null
/// fixed_price : ""
/// tar : [{"type":"input","default_value":"","is_enabled":true,"label":"My label","tar_value":"label1"},{"type":"checkbox","default_value":"","is_enabled":true,"label":"This is my checkbox","tar_value":"checkbox_1"},{"type":"location","default_value":"","is_enabled":true,"label":"Start Location","tar_value":"start_location"},{"type":"location","default_value":"","is_enabled":true,"label":"End Location","tar_value":"end_location"}]

class ServiceValue {
  int id;
  String name;
  String image_path;
  String description;
  String view_type;
  List<ServiceValue> values;
  double price = 20;
  List<ServiceTarget> targets;

  ServiceValue(
      {int id,
      String name,
      String image,
      String description,
      String viewType,
      List<ServiceValue> values,
      double fixedPrice,
      List<ServiceTarget> tar}) {
    this.id = id;
    this.name = name;
    this.image_path = image;
    this.description = description;
    this.view_type = viewType;
    this.values = values;
    this.price = fixedPrice;
    this.targets = tar;
  }

  ServiceValue.fromJson(dynamic json) {
    this.id = json["id"];
    this.name = json["name"];
    if (json["image_path"] != null)
      this.image_path = json["image_path"];
    else
      this.image_path = "";
    this.description = json["description"];
    this.view_type = json["view_type"];
    if (json["values"] != null) {
      this.values = [];
      json["values"].forEach((v) {
        this.values.add(ServiceValue.fromJson(v));
      });
    }
    if (json['price'] != null)
      this.price = double.parse(json["price"]);
    if (json["targets"] != null) {
      this.targets = [];
      json["targets"].forEach((v) {
        this.targets.add(ServiceTarget.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = this.id;
    map["name"] = this.name;
    map["image_path"] = image_path;
    map["description"] = description;
    map["view_type"] = view_type;
    map["values"] = values;
    map["price"] = price;
    if (targets != null) {
      map["targets"] = targets.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// type : "input"
/// default_value : ""
/// is_enabled : true
/// label : "My label"
/// tar_value : "label1"

class ServiceTarget {
  String type;
  String default_value;
  int is_enabled;
  String label;
  String target_value;

  ServiceTarget(
      {String type,
      String defaultValue,
      int isEnabled,
      String label,
      int tarValue}) {
    this.type = type;
    this.default_value = defaultValue;
    this.is_enabled = isEnabled;
    this.label = label;
    this.target_value = tarValue.toString();
  }

  ServiceTarget.fromJson(dynamic json) {
    type = json["type"];
    default_value = json["default_value"];
    is_enabled = json["is_enabled"];
    label = json["label"];
    target_value = json["target_value"].toString();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["default_value"] = default_value;
    map["is_enabled"] = is_enabled;
    map["label"] = label;
    map["target_value"] = int.parse(target_value);
    return map;
  }
}
