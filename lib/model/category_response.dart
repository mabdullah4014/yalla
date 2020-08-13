/// code : 200
/// data : [{"id":1,"name":"Cleaning and Laundry Services","image":"","description":"","services":[{"id":1,"name":"House cleaning and home maid","image":"https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png","description":"","category_id":1,"view_type":"list","values":[{"id":1,"name":"House","image":"","view_type":"grid","description":"","values":[{"id":3,"name":"One floor","view_type":"list","image":"","description":"","values":[{"id":23,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":56,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]},{"id":4,"name":"Two floor","view_type":"grid","image":"","description":"","values":[{"id":98,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":59,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]}]},{"id":2,"name":"Apartment","view_type":"grid","image":"","description":"","values":[{"id":123,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":868,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]}]},{"id":765,"name":"Carpet and Furniture Cleaning","image":"https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png","description":"","category_id":"","view_type":"grid","values":[{"id":861,"name":"Carpet Wash","image":"","description":"","view_type":"list","values":[{"id":1234,"name":"1250 dinar per meter","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]},{"id":567,"name":"Sofa Wash","image":"","view_type":"list","description":"","values":[{"id":"9864","name":"10 person sofa set 30000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":458,"name":"L shape sofa 25000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":541,"name":"7 person sofa set","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":813,"name":"5 person sofa set","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]}]}]}]
/// message : ""

class CategoryResponse {
  int _code;
  List<Category> _data;
  String _message;

  int get code => _code;

  List<Category> get data => _data;

  String get message => _message;

  CategoryResponse({int code, List<Category> data, String message}) {
    _code = code;
    _data = data;
    _message = message;
  }

  CategoryResponse.fromJson(dynamic json) {
    _code = json["code"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Category.fromJson(v));
      });
    }
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["message"] = _message;
    return map;
  }
}

/// id : 1
/// name : "Cleaning and Laundry Services"
/// image : ""
/// description : ""
/// services : [{"id":1,"name":"House cleaning and home maid","image":"https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png","description":"","category_id":1,"view_type":"list","values":[{"id":1,"name":"House","image":"","view_type":"grid","description":"","values":[{"id":3,"name":"One floor","view_type":"list","image":"","description":"","values":[{"id":23,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":56,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]},{"id":4,"name":"Two floor","view_type":"grid","image":"","description":"","values":[{"id":98,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":59,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]}]},{"id":2,"name":"Apartment","view_type":"grid","image":"","description":"","values":[{"id":123,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":868,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]}]},{"id":765,"name":"Carpet and Furniture Cleaning","image":"https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png","description":"","category_id":"","view_type":"grid","values":[{"id":861,"name":"Carpet Wash","image":"","description":"","view_type":"list","values":[{"id":1234,"name":"1250 dinar per meter","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]},{"id":567,"name":"Sofa Wash","image":"","view_type":"list","description":"","values":[{"id":"9864","name":"10 person sofa set 30000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":458,"name":"L shape sofa 25000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":541,"name":"7 person sofa set","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":813,"name":"5 person sofa set","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]}]}]

class Category {
  int _id;
  String _name;
  String _image;
  String _description;
  List<YallaService> _services;

  int get id => _id;

  String get name => _name;

  String get image => _image;

  String get description => _description;

  List<YallaService> get services => _services;

  Category(
      {int id,
      String name,
      String image,
      String description,
      List<YallaService> services}) {
    _id = id;
    _name = name;
    _image = image;
    _description = description;
    _services = services;
  }

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _image = json["image"];
    _description = json["description"];
    if (json["services"] != null) {
      _services = [];
      json["services"].forEach((v) {
        _services.add(YallaService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["image"] = _image;
    map["description"] = _description;
    if (_services != null) {
      map["services"] = _services.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "House cleaning and home maid"
/// image : "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png"
/// description : ""
/// category_id : 1
/// view_type : "list"
/// values : [{"id":1,"name":"House","image":"","view_type":"grid","description":"","values":[{"id":3,"name":"One floor","view_type":"list","image":"","description":"","values":[{"id":23,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":56,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]},{"id":4,"name":"Two floor","view_type":"grid","image":"","description":"","values":[{"id":98,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":59,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]}]},{"id":2,"name":"Apartment","view_type":"grid","image":"","description":"","values":[{"id":123,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":868,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]}]

class YallaService {
  int _id;
  String _name;
  String _image;
  String _description;
  int _categoryId;
  String _viewType;
  List<ServiceValue> _values;

  int get id => _id;

  String get name => _name;

  String get image => _image;

  String get description => _description;

  int get categoryId => _categoryId;

  String get viewType => _viewType;

  List<ServiceValue> get values => _values;

  YallaService(
      {int id,
      String name,
      String image,
      String description,
      int categoryId,
      String viewType,
      List<ServiceValue> values}) {
    _id = id;
    _name = name;
    _image = image;
    _description = description;
    _categoryId = categoryId;
    _viewType = viewType;
    _values = values;
  }

  YallaService.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _image = json["image"];
    _description = json["description"];
//    _categoryId = json["category_id"];
    _viewType = json["view_type"];
    if (json["values"] != null) {
      _values = [];
      json["values"].forEach((v) {
        _values.add(ServiceValue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["image"] = _image;
    map["description"] = _description;
//    map["category_id"] = _categoryId;
    map["view_type"] = _viewType;
    if (_values != null) {
      map["values"] = _values.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "House"
/// image : ""
/// view_type : "grid"
/// description : ""
/// values : [{"id":3,"name":"One floor","view_type":"list","image":"","description":"","values":[{"id":23,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":56,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]},{"id":4,"name":"Two floor","view_type":"grid","image":"","description":"","values":[{"id":98,"name":"Empty House 35000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]},{"id":59,"name":"Occupied House 40000","image":"","description":"","values":null,"target":[{"type":"input","label":"My label","target_value":"label1"},{"type":"location","label":"Start Location","target_value":"start_location"},{"type":"location","label":"End Location","target_value":"end_location"}]}]}]

class ServiceValue {
  int _id;
  String _name;
  String _image;
  String _viewType;
  String _description;
  List<Target> _target;
  List<ServiceValue> _values;

  int get id => _id;

  String get name => _name;

  String get image => _image;

  String get viewType => _viewType;

  String get description => _description;

  List<Target> get target => _target;

  List<ServiceValue> get values => _values;

  ServiceValue(
      {int id,
      String name,
      String image,
      String viewType,
      String description,
      List<Target> target,
      List<ServiceValue> values}) {
    _id = id;
    _name = name;
    _image = image;
    _viewType = viewType;
    _description = description;
    _values = values;
    _target = target;
  }

  ServiceValue.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _image = json["image"];
    _viewType = json["view_type"];
    _description = json["description"];
    if (json["values"] != null) {
      _values = [];
      json["values"].forEach((v) {
        _values.add(ServiceValue.fromJson(v));
      });
    }
    if (json["target"] != null) {
      _target = [];
      json["target"].forEach((v) {
        _target.add(Target.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["image"] = _image;
    map["view_type"] = _viewType;
    map["target"] = _target;
    map["description"] = _description;
    if (_values != null) {
      map["values"] = _values.map((v) => v.toJson()).toList();
    }
    if (_target != null) {
      map["target"] = _target.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// type : "input"
/// label : "My label"
/// target_value : "label1"

class Target {
  String _type;
  String _label;
  String _targetValue;

  String get type => _type;

  String get label => _label;

  String get targetValue => _targetValue;

  Target({String type, String label, String targetValue}) {
    _type = type;
    _label = label;
    _targetValue = targetValue;
  }

  Target.fromJson(dynamic json) {
    _type = json["type"];
    _label = json["label"];
    _targetValue = json["target_value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = _type;
    map["label"] = _label;
    map["target_value"] = _targetValue;
    return map;
  }
}
