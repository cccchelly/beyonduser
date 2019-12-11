class MainData {
  List<BannersListBean> banners;
  List<CasusListBean> casus;
  List<CommoditiesListBean> commodities;
  List<NewsListBean> news;

  MainData({this.banners, this.casus, this.commodities, this.news});

  MainData.fromJson(Map<String, dynamic> json) {    
    this.banners = (json['banners'] as List)!=null?(json['banners'] as List).map((i) => BannersListBean.fromJson(i)).toList():null;
    this.casus = (json['casus'] as List)!=null?(json['casus'] as List).map((i) => CasusListBean.fromJson(i)).toList():null;
    this.commodities = (json['commodities'] as List)!=null?(json['commodities'] as List).map((i) => CommoditiesListBean.fromJson(i)).toList():null;
    this.news = (json['news'] as List)!=null?(json['news'] as List).map((i) => NewsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banners'] = this.banners != null?this.banners.map((i) => i.toJson()).toList():null;
    data['casus'] = this.casus != null?this.casus.map((i) => i.toJson()).toList():null;
    data['commodities'] = this.commodities != null?this.commodities.map((i) => i.toJson()).toList():null;
    data['news'] = this.news != null?this.news.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class BannersListBean {
  String creator;
  String imgUrl;
  String url;
  int id;
  num createtime;

  BannersListBean({this.creator, this.imgUrl, this.url, this.id, this.createtime});

  BannersListBean.fromJson(Map<String, dynamic> json) {    
    this.creator = json['creator'];
    this.imgUrl = json['imgUrl'];
    this.url = json['url'];
    this.id = json['id'];
    this.createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creator'] = this.creator;
    data['imgUrl'] = this.imgUrl;
    data['url'] = this.url;
    data['id'] = this.id;
    data['createtime'] = this.createtime;
    return data;
  }
}

class CasusListBean {
  String content;
  String creator;
  String faceImg;
  String sketch;
  String url;
  int id;
  int sort;
  int turn;
  num createtime;

  CasusListBean({this.content, this.creator, this.faceImg, this.sketch, this.url, this.id, this.sort, this.turn, this.createtime});

  CasusListBean.fromJson(Map<String, dynamic> json) {    
    this.content = json['content'];
    this.creator = json['creator'];
    this.faceImg = json['faceImg'];
    this.sketch = json['sketch'];
    this.url = json['url'];
    this.id = json['id'];
    this.sort = json['sort'];
    this.turn = json['turn'];
    this.createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['creator'] = this.creator;
    data['faceImg'] = this.faceImg;
    data['sketch'] = this.sketch;
    data['url'] = this.url;
    data['id'] = this.id;
    data['sort'] = this.sort;
    data['turn'] = this.turn;
    data['createtime'] = this.createtime;
    return data;
  }
}

class CommoditiesListBean {
  String name;
  int createId;
  int id;
  int parentId;
  int recommend;
  int updateId;
  List<AttachementsListBean> attachements;

  CommoditiesListBean({this.name, this.createId, this.id, this.parentId, this.recommend, this.updateId, this.attachements});

  CommoditiesListBean.fromJson(Map<String, dynamic> json) {    
    this.name = json['name'];
    this.createId = json['createId'];
    this.id = json['id'];
    this.parentId = json['parentId'];
    this.recommend = json['recommend'];
    this.updateId = json['updateId'];
    this.attachements = (json['attachements'] as List)!=null?(json['attachements'] as List).map((i) => AttachementsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['createId'] = this.createId;
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['recommend'] = this.recommend;
    data['updateId'] = this.updateId;
    data['attachements'] = this.attachements != null?this.attachements.map((i) => i.toJson()).toList():null;
    return data;
  }
}

class NewsListBean {
  String content;
  String creator;
  String faceImg;
  String title;
  String url;
  int id;
  int sort;
  int turn;
  num createtime;

  NewsListBean({this.content, this.creator, this.faceImg, this.title, this.url, this.id, this.sort, this.turn, this.createtime});

  NewsListBean.fromJson(Map<String, dynamic> json) {    
    this.content = json['content'];
    this.creator = json['creator'];
    this.faceImg = json['faceImg'];
    this.title = json['title'];
    this.url = json['url'];
    this.id = json['id'];
    this.sort = json['sort'];
    this.turn = json['turn'];
    this.createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['creator'] = this.creator;
    data['faceImg'] = this.faceImg;
    data['title'] = this.title;
    data['url'] = this.url;
    data['id'] = this.id;
    data['sort'] = this.sort;
    data['turn'] = this.turn;
    data['createtime'] = this.createtime;
    return data;
  }
}

class AttachementsListBean {
  String newName;
  String oldName;
  String suffix;
  String uri;
  int attType;
  int fkId;
  int id;
  int size;
  int type;
  num createtime;

  AttachementsListBean({this.newName, this.oldName, this.suffix, this.uri, this.attType, this.fkId, this.id, this.size, this.type, this.createtime});

  AttachementsListBean.fromJson(Map<String, dynamic> json) {    
    this.newName = json['newName'];
    this.oldName = json['oldName'];
    this.suffix = json['suffix'];
    this.uri = json['uri'];
    this.attType = json['attType'];
    this.fkId = json['fkId'];
    this.id = json['id'];
    this.size = json['size'];
    this.type = json['type'];
    this.createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newName'] = this.newName;
    data['oldName'] = this.oldName;
    data['suffix'] = this.suffix;
    data['uri'] = this.uri;
    data['attType'] = this.attType;
    data['fkId'] = this.fkId;
    data['id'] = this.id;
    data['size'] = this.size;
    data['type'] = this.type;
    data['createtime'] = this.createtime;
    return data;
  }
}

/*

{
"news": [
{
"content": "宋体",
"createtime": 1536564947000,
"creator": "jorge",
"faceImg": "upload/e7f85ad6feca4c838503e5763375f086.png",
"id": 7,
"sort": 99,
"title": "春游赏花季，你赏花了吗",
"turn": 1,
"url": ""
}
],
"casus": [
{
"content": "<全景展示",
"createtime": 1565938746000,
"creator": "jorge",
"faceImg": "upload/52b753937ef84090921cbafd0ac6b598QQ图片20190816145820.png",
"id": 7,
"sketch": "忠县全景图",
"sort": 1,
"turn": 2,
"url": "http: //h5.scyphr.com/vr/zhongxian/"
}
],
"commodities": [
{
"attachements": [
{
"attType": 1,
"createtime": 1536631164000,
"fkId": 1,
"id": 72,
"newName": "d227bf2ae96d4043892c2019-10-2514: 04: 24.15620005-20095/com.example.beyond_user.hostI/flutter: cadd352.png",
"oldName": "交流电频振式杀虫灯",
"size": 0,
"suffix": ".png",
"type": 0,
"uri": "upload/d227bf2ae96d4043892cfc9f7cadd352.png"
}
],
"createId": 0,
"id": 1,
"name": "交流电频振式杀虫灯",
"parentId": 0,
"recommend": 0,
"updateId": 0
},
{
"attachements": [
{
"attType": 1,
"createtime": 1536315575000,
"fkId": 2,
"id": 55,
"newName": "28fb6f48604b43389c1f332fecbc66e9.png",
"oldName": "太阳能频振式杀虫灯（2.2米）",
"size": 0,
"suffix": ".png",
"type": 0,
"uri": "upload/28fb6f48604b43389c1f332fecbc66e9.png"
}
],
"createId": 0,
"id": 2,
"name": "太阳能频振式杀虫灯（2.2米）",
"parentId": 0,
"recommend": 0,
"updateId": 0
},
{
"attachements": [
{
"attType": 1,
"createtime": 1536289572000,
"fkId": 4,
"id": 33,
"newName": "ff8f195b4ce2463486b1e06d4ac0c21d.png",
"oldName": "太阳能频振式杀虫灯（2.8米）",
"size": 0,
"suffix": ".png",
"type": 0,
"uri": "upload/ff8f195b4ce2463486b1e06d4ac0c21d.png"
}
],
"createId": 0,
"id": 4,
"name": "太阳能频振2019-10-2514: 04: 24.15620005-20095/com.example.beyond_user.hostI/flutter: 式杀虫灯（2.8米）",
"parentId": 0,
"recommend": 0,
"updateId": 0
},
{
"attachements": [
{
"attType": 1,
"createtime": 1536583623000,
"fkId": 7,
"id": 71,
"newName": "97622cbe59474151850d2c3a74405ce1.png",
"oldName": "太阳能频振式杀虫灯",
"size": 0,
"suffix": ".png",
"type": 0,
"uri": "upload/97622cbe59474151850d2c3a74405ce1.png"
}
],
"createId": 0,
"id": 7,
"name": "太阳能频振式杀虫灯",
"parentId": 0,
"recommend": 0,
"updateId": 0
},
{
"attachements": [
{
"attType": 1,
"createtime": 1536290453000,
"fkId": 19,
"id": 38,
"newName": "a0711d20114c45e094b35f2cae3f3163.png",
"oldName": "自动跟踪太阳能杀虫灯",
"size": 0,
"suffix": ".png",
"type": 0,
"uri": "upload/a0711d20114c45e094b35f2cae3f3163.png"
}
],
"createId": 0,
"id": 19,
"name": "自动跟踪太阳能杀虫灯",
"parentId": 0,
"recommend": 0,
"updateId": 0
},
{
"attachements": [
{
"attType": 1,
"createtime": 1536290653000,
"fkId": 20,
"id": 39,
"newName": "68a35f50f21c41339204104a95f50.p2019-10-2514: 04: 24.15620005-20095/com.example.beyond_user.hostI/flutter: ng",
"oldName": "旋转清虫太阳能杀虫灯",
"size": 0,
"suffix": ".png",
"type": 0,
"uri": "upload/68a35f50f21c41339204104a95f50.png"
}
],
"createId": 0,
"id": 20,
"name": "旋转清虫太阳能杀虫灯",
"parentId": 0,
"recommend": 0,
"updateId": 0
}
],
"banners": [
{
"createtime": 1535967684000,
"creator": "jorge",
"id": 2,
"imgUrl": "upload/e5be4d6ea5154e308e0caa5fcedd4cfabanner2.png",
"url": "http: //www.cdbeyond.com/"
},
{
"createtime": 1536718643000,
"creator": "jorge",
"id": 3,
"imgUrl": "upload/ef46da93e0644fa193de9e549ffb0eb2banner1.png",
"url": "http: //www.cdbeyond.com/news.asp?id=506"
}
]
}*/
