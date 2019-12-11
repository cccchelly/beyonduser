class VideoBallPicData {
  String name;
  String recordDesc;
  String imgUrl;
  String owner;
  String imei;
  int id;
  int since;
  num recordDate;

  VideoBallPicData({this.name, this.recordDesc, this.imgUrl, this.owner, this.imei, this.id, this.since, this.recordDate});

  VideoBallPicData.fromJson(Map<String, dynamic> json) {    
    this.name = json['name'];
    this.recordDesc = json['recordDesc'];
    this.imgUrl = json['imgUrl'];
    this.owner = json['owner'];
    this.imei = json['imei'];
    this.id = json['id'];
    this.since = json['since'];
    this.recordDate = json['recordDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['recordDesc'] = this.recordDesc;
    data['imgUrl'] = this.imgUrl;
    data['owner'] = this.owner;
    data['imei'] = this.imei;
    data['id'] = this.id;
    data['since'] = this.since;
    data['recordDate'] = this.recordDate;
    return data;
  }

}

/*{
"id": 140,
"name": null,
"recordDesc": "设备定时上传",
"recordDate": 1569718986000,
"imgUrl": "http://alstatic.chinazhix.cn/DS-2CD7T47DWD-IZGL20190613AACHD3=2f0f3309-dec3-4d16-a813-7dd6e132ba61.jpg",
"owner": null,
"imei": "DS-2CD7T47DWD-IZGL20190613AACHD3",
"since": 2
}*/
