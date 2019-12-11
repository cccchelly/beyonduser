class WormPicData {
  String auditor;
  String confirm;
  num confirmTime;
  num countDate;
  String countUser;
  num createId;
  num ibId;
  String mibile;
  String mode;
  String name;
  String opt;
  num pestCount;
  String upDown;
  num updateDate;
  String updateId;
  String url;
  String urlTo10P;
  String version;
  String weather;
  num deviceId;
  String id;
  num createDate;
  num photoDate;
  num photoTime;

  WormPicData({this.auditor, this.confirm, this.confirmTime, this.countDate, this.countUser, this.createId, this.ibId, this.mibile, this.mode, this.name, this.opt, this.pestCount, this.upDown, this.updateDate, this.updateId, this.url, this.urlTo10P, this.version, this.weather, this.deviceId, this.id, this.createDate, this.photoDate, this.photoTime});

  WormPicData.fromJson(Map<String, dynamic> json) {    
    this.auditor = json['auditor'];
    this.confirm = json['confirm'];
    this.confirmTime = json['confirmTime'];
    this.countDate = json['countDate'];
    this.countUser = json['countUser'];
    this.createId = json['createId'];
    this.ibId = json['ibId'];
    this.mibile = json['mibile'];
    this.mode = json['mode'];
    this.name = json['name'];
    this.opt = json['opt'];
    this.pestCount = json['pestCount'];
    this.upDown = json['upDown'];
    this.updateDate = json['updateDate'];
    this.updateId = json['updateId'];
    this.url = json['url'];
    this.urlTo10P = json['urlTo10P'];
    this.version = json['version'];
    this.weather = json['weather'];
    this.deviceId = json['deviceId'];
    this.id = json['id'];
    this.createDate = json['createDate'];
    this.photoDate = json['photoDate'];
    this.photoTime = json['photoTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auditor'] = this.auditor;
    data['confirm'] = this.confirm;
    data['confirmTime'] = this.confirmTime;
    data['countDate'] = this.countDate;
    data['countUser'] = this.countUser;
    data['createId'] = this.createId;
    data['ibId'] = this.ibId;
    data['mibile'] = this.mibile;
    data['mode'] = this.mode;
    data['name'] = this.name;
    data['opt'] = this.opt;
    data['pestCount'] = this.pestCount;
    data['upDown'] = this.upDown;
    data['updateDate'] = this.updateDate;
    data['updateId'] = this.updateId;
    data['url'] = this.url;
    data['urlTo10P'] = this.urlTo10P;
    data['version'] = this.version;
    data['weather'] = this.weather;
    data['deviceId'] = this.deviceId;
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['photoDate'] = this.photoDate;
    data['photoTime'] = this.photoTime;
    return data;
  }

}
