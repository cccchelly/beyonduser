class SoilData {
  String id;
  String moistureName;
  String address;
  int status;

  SoilData({this.id, this.moistureName, this.address, this.status});

  SoilData.fromJson(Map<String, dynamic> json) {    
    this.id = json['id'];
    this.moistureName = json['moistureName'];
    this.address = json['address'];
    this.status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['moistureName'] = this.moistureName;
    data['address'] = this.address;
    data['status'] = this.status;
    return data;
  }

}
