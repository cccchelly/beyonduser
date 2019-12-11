class DeviceNumData {
  int localLamp;
  int weather;
  int lamp;
  int forecast;
  int moisture;
  int spore;
  int seedling;

  DeviceNumData({this.localLamp, this.weather, this.lamp, this.forecast, this.moisture, this.spore, this.seedling});

  DeviceNumData.fromJson(Map<String, dynamic> json) {    
    this.localLamp = json['localLamp'];
    this.weather = json['weather'];
    this.lamp = json['lamp'];
    this.forecast = json['forecast'];
    this.moisture = json['moisture'];
    this.spore = json['spore'];
    this.seedling = json['seedling'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['localLamp'] = this.localLamp;
    data['weather'] = this.weather;
    data['lamp'] = this.lamp;
    data['forecast'] = this.forecast;
    data['moisture'] = this.moisture;
    data['spore'] = this.spore;
    data['seedling'] = this.seedling;
    return data;
  }

}
