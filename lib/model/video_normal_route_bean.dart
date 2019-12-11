

class VideoRouteData{
  String _deviceSerial;
  int _channelNo;
  int _addressIndex;

  VideoRouteData(this._deviceSerial, this._channelNo, this._addressIndex);

  int get addressIndex => _addressIndex;

  set addressIndex(int value) {
    _addressIndex = value;
  }

  int get channelNo => _channelNo;

  set channelNo(int value) {
    _channelNo = value;
  }

  String get deviceSerial => _deviceSerial;

  set deviceSerial(String value) {
    _deviceSerial = value;
  }


}