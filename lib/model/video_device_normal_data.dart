class VideoDeviceNormalData {
  String channelName;
  String deviceSerial;
  String picUrl;
  int channelNo;
  int isEncrypt;
  int status;
  int videoLevel;

  VideoDeviceNormalData({this.channelName, this.deviceSerial, this.picUrl, this.channelNo, this.isEncrypt, this.status, this.videoLevel});

  VideoDeviceNormalData.fromJson(Map<String, dynamic> json) {    
    this.channelName = json['channelName'];
    this.deviceSerial = json['deviceSerial'];
    this.picUrl = json['picUrl'];
    this.channelNo = json['channelNo'];
    this.isEncrypt = json['isEncrypt'];
    this.status = json['status'];
    this.videoLevel = json['videoLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelName'] = this.channelName;
    data['deviceSerial'] = this.deviceSerial;
    data['picUrl'] = this.picUrl;
    data['channelNo'] = this.channelNo;
    data['isEncrypt'] = this.isEncrypt;
    data['status'] = this.status;
    data['videoLevel'] = this.videoLevel;
    return data;
  }

}


/*{
"channelName": "视频30@DS-8832N-K8(C57795544)",
"channelNo": 30,
"deviceSerial": "C57795544",
"isEncrypt": 0,
"picUrl": "https://statics.ys7.com/device/assets/imgs/public/homeDevice.jpeg",
"status": 0,
"videoLevel": 0
}*/
