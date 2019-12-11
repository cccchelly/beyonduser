class WormLineData {
  List<String> xData;
  List<int> yData;

  WormLineData({this.xData, this.yData});

  WormLineData.fromJson(Map<String, dynamic> json) {    

    List<dynamic> xDataList = json['xData'];
    this.xData = new List();
    this.xData.addAll(xDataList.map((o) => o.toString()));

    List<dynamic> yDataList = json['yData'];
    this.yData = new List();
    this.yData.addAll(yDataList.map((o) => int.parse(o.toString())));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xData'] = this.xData;
    data['yData'] = this.yData;
    return data;
  }

}
