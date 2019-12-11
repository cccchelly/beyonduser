class WeaStaListData {
  String id;
  String name;
  String imei;
  String owner;
  String telephone;
  String address;
  String vendor;

  WeaStaListData({this.id, this.name, this.imei, this.owner, this.telephone, this.address, this.vendor});

  WeaStaListData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.imei = json['imei'];
    this.owner = json['owner'];
    this.telephone = json['telephone'];
    this.address = json['address'];
    this.vendor = json['vendor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imei'] = this.imei;
    data['owner'] = this.owner;
    data['telephone'] = this.telephone;
    data['address'] = this.address;
    data['vendor'] = this.vendor;
    return data;
  }

}
