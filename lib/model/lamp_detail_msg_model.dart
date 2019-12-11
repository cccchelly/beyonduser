class LampDetailMsgModel {
  String sn;
  String statHour;
  String mode;
  double vol;
  double sunVol;
  double highVol;
  double temp;
  double humidity;
  double lng;
  double lat;
  int id;
  int status;
  int alert;
  int dct;
  int power;
  int powst;
  int devst;
  int re;
  num time;
  num updateTime;

  LampDetailMsgModel({this.sn, this.statHour, this.mode, this.vol, this.sunVol, this.highVol, this.temp, this.humidity, this.lng, this.lat, this.id, this.status, this.alert, this.dct, this.power, this.powst, this.devst, this.re, this.time, this.updateTime});

  LampDetailMsgModel.fromJson(Map<String, dynamic> json) {    
    this.sn = json['sn'];
    this.statHour = json['statHour'];
    this.mode = json['mode'];
    this.vol = json['vol'];
    this.sunVol = json['sunVol'];
    this.highVol = json['highVol'];
    this.temp = json['temp'];
    this.humidity = json['humidity'];
    this.lng = json['lng'];
    this.lat = json['lat'];
    this.id = json['id'];
    this.status = json['status'];
    this.alert = json['alert'];
    this.dct = json['dct'];
    this.power = json['power'];
    this.powst = json['powst'];
    this.devst = json['devst'];
    this.re = json['re'];
    this.time = json['time'];
    this.updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sn'] = this.sn;
    data['statHour'] = this.statHour;
    data['mode'] = this.mode;
    data['vol'] = this.vol;
    data['sunVol'] = this.sunVol;
    data['highVol'] = this.highVol;
    data['temp'] = this.temp;
    data['humidity'] = this.humidity;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['id'] = this.id;
    data['status'] = this.status;
    data['alert'] = this.alert;
    data['dct'] = this.dct;
    data['power'] = this.power;
    data['powst'] = this.powst;
    data['devst'] = this.devst;
    data['re'] = this.re;
    data['time'] = this.time;
    data['updateTime'] = this.updateTime;
    return data;
  }

}
