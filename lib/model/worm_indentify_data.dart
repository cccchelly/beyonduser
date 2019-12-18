class WormIndentifyData {
  String score;
  String name;

  WormIndentifyData({this.score, this.name});

  WormIndentifyData.fromJson(Map<String, dynamic> json) {    
    this.score = json['score'];
    this.name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['name'] = this.name;
    return data;
  }

}
