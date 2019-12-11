class LampListModel {
  String sn;
  String label;
  String usedFor;
  String location;
  String did;
  String stateDesc;
  String time;
  String updateTime;
  double lat;
  double lng;
  int status;

  LampListModel({this.sn, this.label, this.usedFor, this.location, this.did, this.stateDesc, this.time, this.updateTime, this.lat, this.lng, this.status});

  LampListModel.fromJson(Map<String, dynamic> json) {    
    this.sn = json['sn'];
    this.label = json['label'];
    this.usedFor = json['usedFor'];
    this.location = json['location'];
    this.did = json['did'];
    this.stateDesc = json['stateDesc'];
    this.time = json['time'];
    this.updateTime = json['updateTime'];
    this.lat = json['lat'];
    this.lng = json['lng'];
    this.status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sn'] = this.sn;
    data['label'] = this.label;
    data['usedFor'] = this.usedFor;
    data['location'] = this.location;
    data['did'] = this.did;
    data['stateDesc'] = this.stateDesc;
    data['time'] = this.time;
    data['updateTime'] = this.updateTime;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['status'] = this.status;
    return data;
  }

}
