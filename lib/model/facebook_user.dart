/// name : "Geekinn Dev"
/// first_name : "Geekinn"
/// picture : {"data":{"height":50,"is_silhouette":true,"url":"https://scontent.fisb5-1.fna.fbcdn.net/v/t1.30497-1/cp0/c15.0.50.50a/p50x50/84628273_176159830277856_972693363922829312_n.jpg?_nc_cat=1&_nc_sid=12b3be&_nc_ohc=4-dhFg8FeL8AX_sEvvx&_nc_ht=scontent.fisb5-1.fna&oh=1da16ff7337c1f34b5c43ac3173a0299&oe=5F697D38","width":50}}
/// last_name : "Dev"
/// email : "dev.geekinntech@gmail.com"
/// id : "308780057009467"

class FacebookUser {
  String _name;
  String _firstName;
  Picture _picture;
  String _lastName;
  String _email;
  String _id;

  String get name => _name;
  String get firstName => _firstName;
  Picture get picture => _picture;
  String get lastName => _lastName;
  String get email => _email;
  String get id => _id;

  FacebookUser({
      String name, 
      String firstName, 
      Picture picture, 
      String lastName, 
      String email, 
      String id}){
    _name = name;
    _firstName = firstName;
    _picture = picture;
    _lastName = lastName;
    _email = email;
    _id = id;
}

  FacebookUser.fromJson(dynamic json) {
    _name = json["name"];
    _firstName = json["firstName"];
    _picture = json["picture"] != null ? Picture.fromJson(json["picture"]) : null;
    _lastName = json["lastName"];
    _email = json["email"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["firstName"] = _firstName;
    if (_picture != null) {
      map["picture"] = _picture.toJson();
    }
    map["lastName"] = _lastName;
    map["email"] = _email;
    map["id"] = _id;
    return map;
  }

}

/// data : {"height":50,"is_silhouette":true,"url":"https://scontent.fisb5-1.fna.fbcdn.net/v/t1.30497-1/cp0/c15.0.50.50a/p50x50/84628273_176159830277856_972693363922829312_n.jpg?_nc_cat=1&_nc_sid=12b3be&_nc_ohc=4-dhFg8FeL8AX_sEvvx&_nc_ht=scontent.fisb5-1.fna&oh=1da16ff7337c1f34b5c43ac3173a0299&oe=5F697D38","width":50}

class Picture {
  Data _data;

  Data get data => _data;

  Picture({
      Data data}){
    _data = data;
}

  Picture.fromJson(dynamic json) {
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// height : 50
/// is_silhouette : true
/// url : "https://scontent.fisb5-1.fna.fbcdn.net/v/t1.30497-1/cp0/c15.0.50.50a/p50x50/84628273_176159830277856_972693363922829312_n.jpg?_nc_cat=1&_nc_sid=12b3be&_nc_ohc=4-dhFg8FeL8AX_sEvvx&_nc_ht=scontent.fisb5-1.fna&oh=1da16ff7337c1f34b5c43ac3173a0299&oe=5F697D38"
/// width : 50

class Data {
  int _height;
  bool _isSilhouette;
  String _url;
  int _width;

  int get height => _height;
  bool get isSilhouette => _isSilhouette;
  String get url => _url;
  int get width => _width;

  Data({
      int height, 
      bool isSilhouette, 
      String url, 
      int width}){
    _height = height;
    _isSilhouette = isSilhouette;
    _url = url;
    _width = width;
}

  Data.fromJson(dynamic json) {
    _height = json["height"];
    _isSilhouette = json["isSilhouette"];
    _url = json["url"];
    _width = json["width"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["height"] = _height;
    map["isSilhouette"] = _isSilhouette;
    map["url"] = _url;
    map["width"] = _width;
    return map;
  }

}