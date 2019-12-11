class VideoNormalShowData {
  String deviceName;
  String deviceSerial;
  String hdAddress;
  String hls;
  String hlsHd;
  String liveAddress;
  String msg;
  String ret;
  String rtmp;
  String rtmpHd;
  int beginTime;
  int channelNo;
  int endTime;
  int exception;
  int status;

  VideoNormalShowData({this.deviceName, this.deviceSerial, this.hdAddress, this.hls, this.hlsHd, this.liveAddress, this.msg, this.ret, this.rtmp, this.rtmpHd, this.beginTime, this.channelNo, this.endTime, this.exception, this.status});

  VideoNormalShowData.fromJson(Map<String, dynamic> json) {    
    this.deviceName = json['deviceName'];
    this.deviceSerial = json['deviceSerial'];
    this.hdAddress = json['hdAddress'];
    this.hls = json['hls'];
    this.hlsHd = json['hlsHd'];
    this.liveAddress = json['liveAddress'];
    this.msg = json['msg'];
    this.ret = json['ret'];
    this.rtmp = json['rtmp'];
    this.rtmpHd = json['rtmpHd'];
    this.beginTime = json['beginTime'];
    this.channelNo = json['channelNo'];
    this.endTime = json['endTime'];
    this.exception = json['exception'];
    this.status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceName'] = this.deviceName;
    data['deviceSerial'] = this.deviceSerial;
    data['hdAddress'] = this.hdAddress;
    data['hls'] = this.hls;
    data['hlsHd'] = this.hlsHd;
    data['liveAddress'] = this.liveAddress;
    data['msg'] = this.msg;
    data['ret'] = this.ret;
    data['rtmp'] = this.rtmp;
    data['rtmpHd'] = this.rtmpHd;
    data['beginTime'] = this.beginTime;
    data['channelNo'] = this.channelNo;
    data['endTime'] = this.endTime;
    data['exception'] = this.exception;
    data['status'] = this.status;
    return data;
  }

}

/*
{
"beginTime": 0,
"channelNo": 10,
"deviceName": "DS-8832N-K8(C57795544)",
"deviceSerial": "C57795544",
"endTime": 0,
"exception": 0,
"hdAddress": "",
"hls": "http://hls01open.ys7.com/openlive/b1f88eae7ab946f8a490af7621b7ab58.m3u8",
"hlsHd": "http://hls01open.ys7.com/openlive/b1f88eae7ab946f8a490af7621b7ab58.hd.m3u8",
"liveAddress": "",
"msg": "",
"ret": "200",
"rtmp": "rtmp://rtmp01open.ys7.com/openlive/b1f88eae7ab946f8a490af7621b7ab58",
"rtmpHd": "rtmp://rtmp01open.ys7.com/openlive/b1f88eae7ab946f8a490af7621b7ab58.hd",
"status": 1
}*/
