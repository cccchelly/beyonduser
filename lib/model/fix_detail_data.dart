import 'dart:convert';

FixDetailData fixDetailDataFromJson(String str) => FixDetailData.fromJson(json.decode(str));

String fixDetailDataToJson(FixDetailData data) => json.encode(data.toJson());

class FixDetailData {
  int id;
  String mno;
  String deviceType;
  String imei;
  String describe;
  String linkman;
  String linkMobile;
  int reportTime;
  int requireTime;
  String problemImg;
  String archivesId;
  int type;
  dynamic remark;
  String state;
  String owner;
  int allocation;
  dynamic cost;
  String reporter;
  String allocator;
  dynamic negotiateTime;
  dynamic allocateTime;
  dynamic called;
  dynamic toCode;
  String manager;
  dynamic faultType;
  String address;
  dynamic fixId;
  dynamic flow;
  dynamic lastState;
  dynamic newestMaintain;
  dynamic repairType;
  dynamic expenseInvoice;
  List<Maintain> maintains;
  List<FlowData> flows;
  dynamic malfuncCallback;
  Device device;
  bool canOperated;

  FixDetailData({
    this.id,
    this.mno,
    this.deviceType,
    this.imei,
    this.describe,
    this.linkman,
    this.linkMobile,
    this.reportTime,
    this.requireTime,
    this.problemImg,
    this.archivesId,
    this.type,
    this.remark,
    this.state,
    this.owner,
    this.allocation,
    this.cost,
    this.reporter,
    this.allocator,
    this.negotiateTime,
    this.allocateTime,
    this.called,
    this.toCode,
    this.manager,
    this.faultType,
    this.address,
    this.fixId,
    this.flow,
    this.lastState,
    this.newestMaintain,
    this.repairType,
    this.expenseInvoice,
    this.maintains,
    this.flows,
    this.malfuncCallback,
    this.device,
    this.canOperated,
  });

  factory FixDetailData.fromJson(Map<String, dynamic> json) => FixDetailData(
    id: json["id"],
    mno: json["mno"],
    deviceType: json["deviceType"],
    imei: json["imei"],
    describe: json["describe"],
    linkman: json["linkman"],
    linkMobile: json["linkMobile"],
    reportTime: json["reportTime"],
    requireTime: json["requireTime"],
    problemImg: json["problemImg"],
    archivesId: json["archivesId"],
    type: json["type"],
    remark: json["remark"],
    state: json["state"],
    owner: json["owner"],
    allocation: json["allocation"],
    cost: json["cost"],
    reporter: json["reporter"],
    allocator: json["allocator"],
    negotiateTime: json["negotiateTime"],
    allocateTime: json["allocateTime"],
    called: json["called"],
    toCode: json["toCode"],
    manager: json["manager"],
    faultType: json["faultType"],
    address: json["address"],
    fixId: json["fixId"],
    flow: json["flow"],
    lastState: json["lastState"],
    newestMaintain: json["newestMaintain"],
    repairType: json["repairType"],
    expenseInvoice: json["expenseInvoice"],
    maintains: List<Maintain>.from(json["maintains"].map((x) => Maintain.fromJson(x))),
    flows: List<FlowData>.from(json["flows"].map((x) => FlowData.fromJson(x))),
    malfuncCallback: json["malfuncCallback"],
    device: Device.fromJson(json["device"]),
    canOperated: json["canOperated"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mno": mno,
    "deviceType": deviceType,
    "imei": imei,
    "describe": describe,
    "linkman": linkman,
    "linkMobile": linkMobile,
    "reportTime": reportTime,
    "requireTime": requireTime,
    "problemImg": problemImg,
    "archivesId": archivesId,
    "type": type,
    "remark": remark,
    "state": state,
    "owner": owner,
    "allocation": allocation,
    "cost": cost,
    "reporter": reporter,
    "allocator": allocator,
    "negotiateTime": negotiateTime,
    "allocateTime": allocateTime,
    "called": called,
    "toCode": toCode,
    "manager": manager,
    "faultType": faultType,
    "address": address,
    "fixId": fixId,
    "flow": flow,
    "lastState": lastState,
    "newestMaintain": newestMaintain,
    "repairType": repairType,
    "expenseInvoice": expenseInvoice,
    "maintains": List<dynamic>.from(maintains.map((x) => x.toJson())),
    "flows": List<dynamic>.from(flows.map((x) => x.toJson())),
    "malfuncCallback": malfuncCallback,
    "device": device.toJson(),
    "canOperated": canOperated,
  };
}

class Device {
  String id;
  int createAt;
  String creator;
  int updateAt;
  String updator;
  int deleted;
  int status;
  String sn;
  String name;
  String owner;
  String admin;
  dynamic usedFor;
  String label;
  String location;
  String archivesId;
  String deviceImg;
  String another;
  String manager;
  String qrCode;
  dynamic departId;
  LampDeviceDetail lampDeviceDetail;
  bool entering;

  Device({
    this.id,
    this.createAt,
    this.creator,
    this.updateAt,
    this.updator,
    this.deleted,
    this.status,
    this.sn,
    this.name,
    this.owner,
    this.admin,
    this.usedFor,
    this.label,
    this.location,
    this.archivesId,
    this.deviceImg,
    this.another,
    this.manager,
    this.qrCode,
    this.departId,
    this.lampDeviceDetail,
    this.entering,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json["id"],
    createAt: json["createAt"],
    creator: json["creator"],
    updateAt: json["updateAt"],
    updator: json["updator"],
    deleted: json["deleted"],
    status: json["status"],
    sn: json["sn"],
    name: json["name"],
    owner: json["owner"],
    admin: json["admin"],
    usedFor: json["usedFor"],
    label: json["label"],
    location: json["location"],
    archivesId: json["archivesId"],
    deviceImg: json["deviceImg"],
    another: json["another"],
    manager: json["manager"],
    qrCode: json["qrCode"],
    departId: json["departId"],
    lampDeviceDetail: LampDeviceDetail.fromJson(json["lampDeviceDetail"]),
    entering: json["entering"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createAt": createAt,
    "creator": creator,
    "updateAt": updateAt,
    "updator": updator,
    "deleted": deleted,
    "status": status,
    "sn": sn,
    "name": name,
    "owner": owner,
    "admin": admin,
    "usedFor": usedFor,
    "label": label,
    "location": location,
    "archivesId": archivesId,
    "deviceImg": deviceImg,
    "another": another,
    "manager": manager,
    "qrCode": qrCode,
    "departId": departId,
    "lampDeviceDetail": lampDeviceDetail.toJson(),
    "entering": entering,
  };
}

class LampDeviceDetail {
  String sn;
  double lat;
  double lng;
  dynamic linkman;
  String address;
  String archivesId;
  int installTime;
  dynamic receptionTime;
  int expireTime;
  int createTime;
  String creator;
  String province;
  String provinceName;
  String city;
  String cityName;
  String district;
  String districtName;
  String baseUser;
  String baseUserMobile;
  dynamic deviceImg;
  int state;
  String reason;
  dynamic telephone;
  String label;
  String model;
  dynamic attachments;
  dynamic projectName;
  dynamic customerArchives;
  dynamic records;
  dynamic stateDevice;
  String stateDesc;
  dynamic device;

  LampDeviceDetail({
    this.sn,
    this.lat,
    this.lng,
    this.linkman,
    this.address,
    this.archivesId,
    this.installTime,
    this.receptionTime,
    this.expireTime,
    this.createTime,
    this.creator,
    this.province,
    this.provinceName,
    this.city,
    this.cityName,
    this.district,
    this.districtName,
    this.baseUser,
    this.baseUserMobile,
    this.deviceImg,
    this.state,
    this.reason,
    this.telephone,
    this.label,
    this.model,
    this.attachments,
    this.projectName,
    this.customerArchives,
    this.records,
    this.stateDevice,
    this.stateDesc,
    this.device,
  });

  factory LampDeviceDetail.fromJson(Map<String, dynamic> json) => LampDeviceDetail(
    sn: json["sn"],
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    linkman: json["linkman"],
    address: json["address"],
    archivesId: json["archivesId"],
    installTime: json["installTime"],
    receptionTime: json["receptionTime"],
    expireTime: json["expireTime"],
    createTime: json["createTime"],
    creator: json["creator"],
    province: json["province"],
    provinceName: json["provinceName"],
    city: json["city"],
    cityName: json["cityName"],
    district: json["district"],
    districtName: json["districtName"],
    baseUser: json["baseUser"],
    baseUserMobile: json["baseUserMobile"],
    deviceImg: json["deviceImg"],
    state: json["state"],
    reason: json["reason"],
    telephone: json["telephone"],
    label: json["label"],
    model: json["model"],
    attachments: json["attachments"],
    projectName: json["projectName"],
    customerArchives: json["customerArchives"],
    records: json["records"],
    stateDevice: json["stateDevice"],
    stateDesc: json["stateDesc"],
    device: json["device"],
  );

  Map<String, dynamic> toJson() => {
    "sn": sn,
    "lat": lat,
    "lng": lng,
    "linkman": linkman,
    "address": address,
    "archivesId": archivesId,
    "installTime": installTime,
    "receptionTime": receptionTime,
    "expireTime": expireTime,
    "createTime": createTime,
    "creator": creator,
    "province": province,
    "provinceName": provinceName,
    "city": city,
    "cityName": cityName,
    "district": district,
    "districtName": districtName,
    "baseUser": baseUser,
    "baseUserMobile": baseUserMobile,
    "deviceImg": deviceImg,
    "state": state,
    "reason": reason,
    "telephone": telephone,
    "label": label,
    "model": model,
    "attachments": attachments,
    "projectName": projectName,
    "customerArchives": customerArchives,
    "records": records,
    "stateDevice": stateDevice,
    "stateDesc": stateDesc,
    "device": device,
  };
}

class FlowData {
  int id;
  String state;
  int parentId;
  String recorder;
  int recordTime;
  String remark;

  FlowData({
    this.id,
    this.state,
    this.parentId,
    this.recorder,
    this.recordTime,
    this.remark,
  });

  factory FlowData.fromJson(Map<String, dynamic> json) => FlowData(
    id: json["id"],
    state: json["state"],
    parentId: json["parentId"],
    recorder: json["recorder"],
    recordTime: json["recordTime"],
    remark: json["remark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state": state,
    "parentId": parentId,
    "recorder": recorder,
    "recordTime": recordTime,
    "remark": remark,
  };
}

class Maintain {
  num id;
  dynamic phenomena;
  dynamic reportTime;
  String reason;
  String dealWay;
  num faultType;
  num status;
  String repairUser;
  num repairTime;
  String repairImg;
  num cost;
  num pid;
  num audit;
  dynamic auditUser;
  dynamic auditTime;
  num createTime;
  dynamic updateTime;
  dynamic evaluate;
  dynamic evaluateReason;
  num travelExpense;
  dynamic backReason;
  num bunkers;
  List<dynamic> quoteItems;
  num totalPrice;
  num repairWay;
  num manPower;

  Maintain({
    this.id,
    this.phenomena,
    this.reportTime,
    this.reason,
    this.dealWay,
    this.faultType,
    this.status,
    this.repairUser,
    this.repairTime,
    this.repairImg,
    this.cost,
    this.pid,
    this.audit,
    this.auditUser,
    this.auditTime,
    this.createTime,
    this.updateTime,
    this.evaluate,
    this.evaluateReason,
    this.travelExpense,
    this.backReason,
    this.bunkers,
    this.quoteItems,
    this.totalPrice,
    this.repairWay,
    this.manPower,
  });

  factory Maintain.fromJson(Map<String, dynamic> json) => Maintain(
    id: json["id"],
    phenomena: json["phenomena"],
    reportTime: json["reportTime"],
    reason: json["reason"],
    dealWay: json["dealWay"],
    faultType: json["faultType"],
    status: json["status"],
    repairUser: json["repairUser"],
    repairTime: json["repairTime"],
    repairImg: json["repairImg"],
    cost: json["cost"],
    pid: json["pid"],
    audit: json["audit"],
    auditUser: json["auditUser"],
    auditTime: json["auditTime"],
    createTime: json["createTime"],
    updateTime: json["updateTime"],
    evaluate: json["evaluate"],
    evaluateReason: json["evaluateReason"],
    travelExpense: json["travelExpense"],
    backReason: json["backReason"],
    bunkers: json["bunkers"].toDouble(),
    quoteItems: List<dynamic>.from(json["quoteItems"].map((x) => x)),
    totalPrice: json["totalPrice"],
    repairWay: json["repairWay"],
    manPower: json["manPower"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phenomena": phenomena,
    "reportTime": reportTime,
    "reason": reason,
    "dealWay": dealWay,
    "faultType": faultType,
    "status": status,
    "repairUser": repairUser,
    "repairTime": repairTime,
    "repairImg": repairImg,
    "cost": cost,
    "pid": pid,
    "audit": audit,
    "auditUser": auditUser,
    "auditTime": auditTime,
    "createTime": createTime,
    "updateTime": updateTime,
    "evaluate": evaluate,
    "evaluateReason": evaluateReason,
    "travelExpense": travelExpense,
    "backReason": backReason,
    "bunkers": bunkers,
    "quoteItems": List<dynamic>.from(quoteItems.map((x) => x)),
    "totalPrice": totalPrice,
    "repairWay": repairWay,
    "manPower": manPower,
  };
}