class LampInstallDetailModel {
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
  String projectName;
  String customerArchives;
  String stateDevice;
  String stateDesc;
  double lat;
  double lng;
  int state;
  num installTime;
  num expireTime;
  num createTime;
  DeviceBean device;
  List<AttachmentsListBean> attachments;
  List<RecordsListBean> records;

  LampInstallDetailModel({this.sn, this.linkman, this.address, this.archivesId, this.receptionTime, this.creator, this.province, this.provinceName, this.city, this.cityName, this.district, this.districtName, this.baseUser, this.baseUserMobile, this.deviceImg, this.reason, this.telephone, this.label, this.model, this.projectName, this.customerArchives, this.stateDevice, this.stateDesc, this.lat, this.lng, this.state, this.installTime, this.expireTime, this.createTime, this.device, this.attachments, this.records});

  LampInstallDetailModel.fromJson(Map<String, dynamic> json) {    
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
    this.projectName = json['projectName'];
    this.customerArchives = json['customerArchives'];
    this.stateDevice = json['stateDevice'];
    this.stateDesc = json['stateDesc'];
    this.lat = json['lat'];
    this.lng = json['lng'];
    this.state = json['state'];
    this.installTime = json['installTime'];
    this.expireTime = json['expireTime'];
    this.createTime = json['createTime'];
    this.device = json['device'] != null ? DeviceBean.fromJson(json['device']) : null;
    this.attachments = (json['attachments'] as List)!=null?(json['attachments'] as List).map((i) => AttachmentsListBean.fromJson(i)).toList():null;
    this.records = (json['records'] as List)!=null?(json['records'] as List).map((i) => RecordsListBean.fromJson(i)).toList():null;
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
    data['projectName'] = this.projectName;
    data['customerArchives'] = this.customerArchives;
    data['stateDevice'] = this.stateDevice;
    data['stateDesc'] = this.stateDesc;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['state'] = this.state;
    data['installTime'] = this.installTime;
    data['expireTime'] = this.expireTime;
    data['createTime'] = this.createTime;
    if (this.device != null) {
      data['device'] = this.device.toJson();
    }
    data['attachments'] = this.attachments != null?this.attachments.map((i) => i.toJson()).toList():null;
    data['records'] = this.records != null?this.records.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class DeviceBean {
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
  String lampDeviceDetail;
  bool entering;
  int deleted;
  int status;
  num createAt;
  num updateAt;

  DeviceBean({this.id, this.creator, this.updator, this.sn, this.name, this.owner, this.admin, this.usedFor, this.label, this.location, this.archivesId, this.deviceImg, this.another, this.manager, this.qrCode, this.departId, this.lampDeviceDetail, this.entering, this.deleted, this.status, this.createAt, this.updateAt});

  DeviceBean.fromJson(Map<String, dynamic> json) {    
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
    this.lampDeviceDetail = json['lampDeviceDetail'];
    this.entering = json['entering'];
    this.deleted = json['deleted'];
    this.status = json['status'];
    this.createAt = json['createAt'];
    this.updateAt = json['updateAt'];
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
    data['lampDeviceDetail'] = this.lampDeviceDetail;
    data['entering'] = this.entering;
    data['deleted'] = this.deleted;
    data['status'] = this.status;
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}

class AttachmentsListBean {
  String id;
  String oldName;
  String newName;
  String type;
  String attType;
  String url;
  String suffix;
  String createTime;
  String size;
  String sn;
  String deviceType;
  String uri;

  AttachmentsListBean({this.id, this.oldName, this.newName, this.type, this.attType, this.url, this.suffix, this.createTime, this.size, this.sn, this.deviceType, this.uri});

  AttachmentsListBean.fromJson(Map<String, dynamic> json) {    
    this.id = json['id'];
    this.oldName = json['oldName'];
    this.newName = json['newName'];
    this.type = json['type'];
    this.attType = json['attType'];
    this.url = json['url'];
    this.suffix = json['suffix'];
    this.createTime = json['createTime'];
    this.size = json['size'];
    this.sn = json['sn'];
    this.deviceType = json['deviceType'];
    this.uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['oldName'] = this.oldName;
    data['newName'] = this.newName;
    data['type'] = this.type;
    data['attType'] = this.attType;
    data['url'] = this.url;
    data['suffix'] = this.suffix;
    data['createTime'] = this.createTime;
    data['size'] = this.size;
    data['sn'] = this.sn;
    data['deviceType'] = this.deviceType;
    data['uri'] = this.uri;
    return data;
  }
}

class RecordsListBean {
  String sn;
  String result;
  String reason;
  String auditor;
  String deviceType;
  int id;
  num auditDate;
  num createDate;

  RecordsListBean({this.sn, this.result, this.reason, this.auditor, this.deviceType, this.id, this.auditDate, this.createDate});

  RecordsListBean.fromJson(Map<String, dynamic> json) {    
    this.sn = json['sn'];
    this.result = json['result'];
    this.reason = json['reason'];
    this.auditor = json['auditor'];
    this.deviceType = json['deviceType'];
    this.id = json['id'];
    this.auditDate = json['auditDate'];
    this.createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sn'] = this.sn;
    data['result'] = this.result;
    data['reason'] = this.reason;
    data['auditor'] = this.auditor;
    data['deviceType'] = this.deviceType;
    data['id'] = this.id;
    data['auditDate'] = this.auditDate;
    data['createDate'] = this.createDate;
    return data;
  }
}
