class UploadPictureData {
  String oldName;
  String suffix;
  String uri;
  String url;
  num newName;

  UploadPictureData({this.oldName, this.suffix, this.uri, this.url, this.newName});

  UploadPictureData.fromJson(Map<String, dynamic> json) {    
    this.oldName = json['oldName'];
    this.suffix = json['suffix'];
    this.uri = json['uri'];
    this.url = json['url'];
    this.newName = json['newName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldName'] = this.oldName;
    data['suffix'] = this.suffix;
    data['uri'] = this.uri;
    data['url'] = this.url;
    data['newName'] = this.newName;
    return data;
  }

}
