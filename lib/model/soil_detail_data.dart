class SoilDetailData {
  List<NewestListBean> newest;

  SoilDetailData({this.newest});

  SoilDetailData.fromJson(Map<String, dynamic> json) {    
    this.newest = (json['newest'] as List)!=null?(json['newest'] as List).map((i) => NewestListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newest'] = this.newest != null?this.newest.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class NewestListBean {
  String imei;
  String id;
  num upDate;
  List<MoistureRecordDetailsListBean> moistureRecordDetails;

  NewestListBean({this.imei, this.id, this.upDate, this.moistureRecordDetails});

  NewestListBean.fromJson(Map<String, dynamic> json) {    
    this.imei = json['imei'];
    this.id = json['id'];
    this.upDate = json['upDate'];
    this.moistureRecordDetails = (json['moistureRecordDetails'] as List)!=null?(json['moistureRecordDetails'] as List).map((i) => MoistureRecordDetailsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imei'] = this.imei;
    data['id'] = this.id;
    data['upDate'] = this.upDate;
    data['moistureRecordDetails'] = this.moistureRecordDetails != null?this.moistureRecordDetails.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class MoistureRecordDetailsListBean {
  String ec;
  String ph;
  num humidity;
  String recordId;
  num temperature;
  num tier;

  MoistureRecordDetailsListBean({this.ec, this.ph, this.humidity, this.recordId, this.temperature, this.tier});

  MoistureRecordDetailsListBean.fromJson(Map<String, dynamic> json) {    
    this.ec = json['ec'];
    this.ph = json['ph'];
    this.humidity = json['humidity'];
    this.recordId = json['recordId'];
    this.temperature = json['temperature'];
    this.tier = json['tier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ec'] = this.ec;
    data['ph'] = this.ph;
    data['humidity'] = this.humidity;
    data['recordId'] = this.recordId;
    data['temperature'] = this.temperature;
    data['tier'] = this.tier;
    return data;
  }
}

class Detail{
  String d;
  num ec;
  String m;
  num ph;
  String upDate;
  String y;
  num humidity;
  num temperature;
  num tier;

  Detail({this.d, this.ec, this.m, this.ph, this.upDate, this.y, this.humidity, this.temperature, this.tier});

  Detail.fromJson(Map<String, dynamic> json) {
    this.d = json['d'];
    this.ec = json['ec'];
    this.m = json['m'];
    this.ph = json['ph'];
    this.upDate = json['upDate'];
    this.y = json['y'];
    this.humidity = json['humidity'];
    this.temperature = json['temperature'];
    this.tier = json['tier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['d'] = this.d;
    data['ec'] = this.ec;
    data['m'] = this.m;
    data['ph'] = this.ph;
    data['upDate'] = this.upDate;
    data['y'] = this.y;
    data['humidity'] = this.humidity;
    data['temperature'] = this.temperature;
    data['tier'] = this.tier;
    return data;
  }
}
