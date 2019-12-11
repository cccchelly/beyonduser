class VideoDeviceBallData {
  String id;
  String creator;
  String updator;
  String ipAddress;
  String username;
  String password;
  String alias;
  String owner;
  String imei;
  String address;
  String province;
  String city;
  String district;
  int deleted;
  int status;
  num createAt;
  num updateAt;
  num lastUpDate;

  VideoDeviceBallData({this.id, this.creator, this.updator, this.ipAddress, this.username, this.password, this.alias, this.owner, this.imei, this.address, this.province, this.city, this.district, this.deleted, this.status, this.createAt, this.updateAt, this.lastUpDate});

  VideoDeviceBallData.fromJson(Map<String, dynamic> json) {    
    this.id = json['id'];
    this.creator = json['creator'];
    this.updator = json['updator'];
    this.ipAddress = json['ipAddress'];
    this.username = json['username'];
    this.password = json['password'];
    this.alias = json['alias'];
    this.owner = json['owner'];
    this.imei = json['imei'];
    this.address = json['address'];
    this.province = json['province'];
    this.city = json['city'];
    this.district = json['district'];
    this.deleted = json['deleted'];
    this.status = json['status'];
    this.createAt = json['createAt'];
    this.updateAt = json['updateAt'];
    this.lastUpDate = json['lastUpDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creator'] = this.creator;
    data['updator'] = this.updator;
    data['ipAddress'] = this.ipAddress;
    data['username'] = this.username;
    data['password'] = this.password;
    data['alias'] = this.alias;
    data['owner'] = this.owner;
    data['imei'] = this.imei;
    data['address'] = this.address;
    data['province'] = this.province;
    data['city'] = this.city;
    data['district'] = this.district;
    data['deleted'] = this.deleted;
    data['status'] = this.status;
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    data['lastUpDate'] = this.lastUpDate;
    return data;
  }

}

/*{
"id": "8",
"createAt": 1569814238000,
"creator": "beadmin",
"updateAt": 1569814247000,
"updator": "beadmin",
"deleted": 0,
"status": 1,
"ipAddress": "192.168.1.62",
"username": "admin",
"password": "Aa123456",
"alias": "局域网1",
"owner": null,
"imei": "DS-2CD7T47DWD-IZGL20190613AACHD3",
"lastUpDate": 1569718986000,
"address": null,
"province": null,
"city": null,
"district": null
}*/
