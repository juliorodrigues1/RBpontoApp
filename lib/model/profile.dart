class Profile {
  int id;
  int employId;
  String people_employ;
  String people;

  Profile({
    this.id,
    this.employId,
    this.people_employ,
    this.people,


  });
  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employId = json['employ_id'];
    people = json['people'];
    people_employ = json['people_employ'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employ_id'] = this.employId;
    data['people_employ'] = this.people_employ;
    data['people'] = this.people;
    return data;
  }

}