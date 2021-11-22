class User {
  String user;
  String password;
  String employ_id;

  User({
    this.user,
    this.password,
    this.employ_id,
  });

  User.fromJson(dynamic json) {
    user = json["user"];
    password = json["password"];
    employ_id = json["employ_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user"] = user;
    map["password"] = password;
    map["employ_id"] = employ_id;
    return map;
  }}