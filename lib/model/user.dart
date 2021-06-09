class User {
  String user;
  String password;

  User({
      this.user, 
      this.password});

  User.fromJson(dynamic json) {
    user = json["user"];
    password = json["password"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user"] = user;
    map["password"] = password;
    return map;
  }

}