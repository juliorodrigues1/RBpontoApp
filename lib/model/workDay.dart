class WorkDay {
  int id;
  int employId;
  bool lack;
  String lat;
  String long;
  String createdAt;
  int emotionId;
  String entryDay;
  String dayOut;
  String entryBack;
  String outOfTheDay;
  String protocol;

  WorkDay(
      {this.id,
      this.employId,
      this.lack,
      this.lat,
      this.long,
      this.createdAt,
      this.emotionId,
      this.entryDay,
      this.dayOut,
      this.entryBack,
      this.outOfTheDay,
      this.protocol});

  WorkDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employId = json['employ_id'];
    lack = json['lack'];
    lat = json['lat'];
    long = json['long'];
    createdAt = json['created_at'];
    emotionId = json['emotion_id'];
    entryDay = json['entry_day'];
    dayOut = json['day_out'];
    entryBack = json['entry_back'];
    outOfTheDay = json['out_of_the_day'];
    protocol = json['protocol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employ_id'] = this.employId;
    data['lack'] = this.lack;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['created_at'] = this.createdAt;
    data['emotion_id'] = this.emotionId;
    data['entry_day'] = this.entryDay;
    data['day_out'] = this.dayOut;
    data['entry_back'] = this.entryBack;
    data['out_of_the_day'] = this.outOfTheDay;
    data['protocol'] = this.protocol;
    return data;
  }
}
