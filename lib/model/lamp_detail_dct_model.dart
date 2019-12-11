class LampDetailDctModel {
  String sn;
  String statDateStr;
  double avgHumidity;
  double avgTemp;
  int type;
  int dct;
  num statDate;

  LampDetailDctModel({this.sn, this.statDateStr, this.avgHumidity, this.avgTemp, this.type, this.dct, this.statDate});

  LampDetailDctModel.fromJson(Map<String, dynamic> json) {    
    this.sn = json['sn'];
    this.statDateStr = json['statDateStr'];
    this.avgHumidity = json['avgHumidity'];
    this.avgTemp = json['avgTemp'];
    this.type = json['type'];
    this.dct = json['dct'];
    this.statDate = json['statDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sn'] = this.sn;
    data['statDateStr'] = this.statDateStr;
    data['avgHumidity'] = this.avgHumidity;
    data['avgTemp'] = this.avgTemp;
    data['type'] = this.type;
    data['dct'] = this.dct;
    data['statDate'] = this.statDate;
    return data;
  }

}
