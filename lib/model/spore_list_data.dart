class SporeListData {
  String id;
  String createAt;
  String creator;
  String updateAt;
  String updator;
  String name;
  String owner;
  String imei;
  String tag;
  String address;
  String departId;
  String linkMobile;
  String base;
  String province;
  String city;
  String district;
  int deleted;
  int status;

  SporeListData({this.id, this.createAt, this.creator, this.updateAt, this.updator, this.name, this.owner, this.imei, this.tag, this.address, this.departId, this.linkMobile, this.base, this.province, this.city, this.district, this.deleted, this.status});

  SporeListData.fromJson(Map<String, dynamic> json) {    
    this.id = json['id'];
    this.createAt = json['createAt'];
    this.creator = json['creator'];
    this.updateAt = json['updateAt'];
    this.updator = json['updator'];
    this.name = json['name'];
    this.owner = json['owner'];
    this.imei = json['imei'];
    this.tag = json['tag'];
    this.address = json['address'];
    this.departId = json['departId'];
    this.linkMobile = json['linkMobile'];
    this.base = json['base'];
    this.province = json['province'];
    this.city = json['city'];
    this.district = json['district'];
    this.deleted = json['deleted'];
    this.status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createAt'] = this.createAt;
    data['creator'] = this.creator;
    data['updateAt'] = this.updateAt;
    data['updator'] = this.updator;
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['imei'] = this.imei;
    data['tag'] = this.tag;
    data['address'] = this.address;
    data['departId'] = this.departId;
    data['linkMobile'] = this.linkMobile;
    data['base'] = this.base;
    data['province'] = this.province;
    data['city'] = this.city;
    data['district'] = this.district;
    data['deleted'] = this.deleted;
    data['status'] = this.status;
    return data;
  }

}
