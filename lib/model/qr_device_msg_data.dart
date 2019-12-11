class QrDeviceMsgData {
  String id;
  String creator;
  String updator;
  String sn;
  String name;
  String owner;
  String admin;
  String usedFor;
  String label;
  String location;
  String archivesId;
  String deviceImg;
  String another;
  String manager;
  String qrCode;
  String departId;
  bool entering;
  int deleted;
  int status;
  num createAt;
  num updateAt;
  LampDeviceDetailBean lampDeviceDetail;

  QrDeviceMsgData({this.id, this.creator, this.updator, this.sn, this.name, this.owner, this.admin, this.usedFor, this.label, this.location, this.archivesId, this.deviceImg, this.another, this.manager, this.qrCode, this.departId, this.entering, this.deleted, this.status, this.createAt, this.updateAt, this.lampDeviceDetail});

  QrDeviceMsgData.fromJson(Map<String, dynamic> json) {    
    this.id = json['id'];
    this.creator = json['creator'];
    this.updator = json['updator'];
    this.sn = json['sn'];
    this.name = json['name'];
    this.owner = json['owner'];
    this.admin = json['admin'];
    this.usedFor = json['usedFor'];
    this.label = json['label'];
    this.location = json['location'];
    this.archivesId = json['archivesId'];
    this.deviceImg = json['deviceImg'];
    this.another = json['another'];
    this.manager = json['manager'];
    this.qrCode = json['qrCode'];
    this.departId = json['departId'];
    this.entering = json['entering'];
    this.deleted = json['deleted'];
    this.status = json['status'];
    this.createAt = json['createAt'];
    this.updateAt = json['updateAt'];
    this.lampDeviceDetail = json['lampDeviceDetail'] != null ? LampDeviceDetailBean.fromJson(json['lampDeviceDetail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creator'] = this.creator;
    data['updator'] = this.updator;
    data['sn'] = this.sn;
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['admin'] = this.admin;
    data['usedFor'] = this.usedFor;
    data['label'] = this.label;
    data['location'] = this.location;
    data['archivesId'] = this.archivesId;
    data['deviceImg'] = this.deviceImg;
    data['another'] = this.another;
    data['manager'] = this.manager;
    data['qrCode'] = this.qrCode;
    data['departId'] = this.departId;
    data['entering'] = this.entering;
    data['deleted'] = this.deleted;
    data['status'] = this.status;
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    if (this.lampDeviceDetail != null) {
      data['lampDeviceDetail'] = this.lampDeviceDetail.toJson();
    }
    return data;
  }

}

class LampDeviceDetailBean {
  String sn;
  String linkman;
  String address;
  String archivesId;
  String receptionTime;
  String creator;
  String province;
  String provinceName;
  String city;
  String cityName;
  String district;
  String districtName;
  String baseUser;
  String baseUserMobile;
  String deviceImg;
  String reason;
  String telephone;
  String label;
  String model;
  String attachments;
  String projectName;
  String customerArchives;
  String records;
  String stateDevice;
  String stateDesc;
  String device;
  double lat;
  double lng;
  int state;
  num installTime;
  num expireTime;
  num createTime;

  LampDeviceDetailBean({this.sn, this.linkman, this.address, this.archivesId, this.receptionTime, this.creator, this.province, this.provinceName, this.city, this.cityName, this.district, this.districtName, this.baseUser, this.baseUserMobile, this.deviceImg, this.reason, this.telephone, this.label, this.model, this.attachments, this.projectName, this.customerArchives, this.records, this.stateDevice, this.stateDesc, this.device, this.lat, this.lng, this.state, this.installTime, this.expireTime, this.createTime});

  LampDeviceDetailBean.fromJson(Map<String, dynamic> json) {    
    this.sn = json['sn'];
    this.linkman = json['linkman'];
    this.address = json['address'];
    this.archivesId = json['archivesId'];
    this.receptionTime = json['receptionTime'];
    this.creator = json['creator'];
    this.province = json['province'];
    this.provinceName = json['provinceName'];
    this.city = json['city'];
    this.cityName = json['cityName'];
    this.district = json['district'];
    this.districtName = json['districtName'];
    this.baseUser = json['baseUser'];
    this.baseUserMobile = json['baseUserMobile'];
    this.deviceImg = json['deviceImg'];
    this.reason = json['reason'];
    this.telephone = json['telephone'];
    this.label = json['label'];
    this.model = json['model'];
    this.attachments = json['attachments'];
    this.projectName = json['projectName'];
    this.customerArchives = json['customerArchives'];
    this.records = json['records'];
    this.stateDevice = json['stateDevice'];
    this.stateDesc = json['stateDesc'];
    this.device = json['device'];
    this.lat = json['lat'];
    this.lng = json['lng'];
    this.state = json['state'];
    this.installTime = json['installTime'];
    this.expireTime = json['expireTime'];
    this.createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sn'] = this.sn;
    data['linkman'] = this.linkman;
    data['address'] = this.address;
    data['archivesId'] = this.archivesId;
    data['receptionTime'] = this.receptionTime;
    data['creator'] = this.creator;
    data['province'] = this.province;
    data['provinceName'] = this.provinceName;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['district'] = this.district;
    data['districtName'] = this.districtName;
    data['baseUser'] = this.baseUser;
    data['baseUserMobile'] = this.baseUserMobile;
    data['deviceImg'] = this.deviceImg;
    data['reason'] = this.reason;
    data['telephone'] = this.telephone;
    data['label'] = this.label;
    data['model'] = this.model;
    data['attachments'] = this.attachments;
    data['projectName'] = this.projectName;
    data['customerArchives'] = this.customerArchives;
    data['records'] = this.records;
    data['stateDevice'] = this.stateDevice;
    data['stateDesc'] = this.stateDesc;
    data['device'] = this.device;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['state'] = this.state;
    data['installTime'] = this.installTime;
    data['expireTime'] = this.expireTime;
    data['createTime'] = this.createTime;
    return data;
  }
}
