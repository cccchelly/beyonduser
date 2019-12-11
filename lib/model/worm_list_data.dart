class WormListData {
  String imei;
  String name;
  String address;
  String owner;
  String phone;
  String longitude;
  String latitude;

  WormListData({this.imei, this.name, this.address, this.owner, this.phone, this.longitude, this.latitude});

  WormListData.fromJson(Map<String, dynamic> json) {    
    this.imei = json['imei'];
    this.name = json['name'];
    this.address = json['address'];
    this.owner = json['owner'];
    this.phone = json['phone'];
    this.longitude = json['longitude'];
    this.latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imei'] = this.imei;
    data['name'] = this.name;
    data['address'] = this.address;
    data['owner'] = this.owner;
    data['phone'] = this.phone;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }

}
