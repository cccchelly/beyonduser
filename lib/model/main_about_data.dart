

class MainAboutData {
  String bgUrl;
  List<Casus> casus;
  String companyDesc;
  String companyName;
  String honor;
  int id;

  MainAboutData({
    this.bgUrl,
    this.casus,
    this.companyDesc,
    this.companyName,
    this.honor,
    this.id,
  });

  factory MainAboutData.fromJson(Map<String, dynamic> json) => new MainAboutData(
    bgUrl: json["bgUrl"],
    casus: new List<Casus>.from(json["casus"].map((x) => Casus.fromJson(x))),
    companyDesc: json["companyDesc"],
    companyName: json["companyName"],
    honor: json["honor"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "bgUrl": bgUrl,
    "casus": new List<dynamic>.from(casus.map((x) => x.toJson())),
    "companyDesc": companyDesc,
    "companyName": companyName,
    "honor": honor,
    "id": id,
  };
}

class Casus {
  String content;
  int createtime;
  String creator;
  String faceImg;
  int id;
  String sketch;
  int sort;
  int turn;
  String url;

  Casus({
    this.content,
    this.createtime,
    this.creator,
    this.faceImg,
    this.id,
    this.sketch,
    this.sort,
    this.turn,
    this.url,
  });

  factory Casus.fromJson(Map<String, dynamic> json) {
    return new Casus(
      content: json["content"],
      createtime: json["createtime"],
      creator: json["creator"],
      faceImg: json["faceImg"],
      id: json["id"],
      sketch: json["sketch"],
      sort: json["sort"],
      turn: json["turn"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "content": content,
    "createtime": createtime,
    "creator": creator,
    "faceImg": faceImg,
    "id": id,
    "sketch": sketch,
    "sort": sort,
    "turn": turn,
    "url": url,
  };
}