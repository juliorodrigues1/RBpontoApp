class ProfileModel {
  String name;
  String organ;
  String lotationCode;
  String lotataionDescription;
  String officeName;
  String bondName;
  String registrationNumber;
  String image;

  ProfileModel(
      {this.name,
        this.organ,
        this.lotationCode,
        this.lotataionDescription,
        this.officeName,
        this.bondName,
        this.registrationNumber,
        this.image});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    organ = json['organ'];
    lotationCode = json['lotation_code'];
    lotataionDescription = json['lotataion_description'];
    officeName = json['office_name'];
    bondName = json['bond_name'];
    registrationNumber = json['registration_number'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['organ'] = this.organ;
    data['lotation_code'] = this.lotationCode;
    data['lotataion_description'] = this.lotataionDescription;
    data['office_name'] = this.officeName;
    data['bond_name'] = this.bondName;
    data['registration_number'] = this.registrationNumber;
    data['image'] = this.image;
    return data;
  }
}