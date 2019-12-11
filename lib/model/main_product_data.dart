class MainProductData {
  String typeName;
  int id;
  int typeStatus;
  List<CommoditiesListBean> commodities;

  MainProductData({this.typeName, this.id, this.typeStatus, this.commodities});

  MainProductData.fromJson(Map<String, dynamic> json) {    
    this.typeName = json['typeName'];
    this.id = json['id'];
    this.typeStatus = json['typeStatus'];
    this.commodities = (json['commodities'] as List)!=null?(json['commodities'] as List).map((i) => CommoditiesListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeName'] = this.typeName;
    data['id'] = this.id;
    data['typeStatus'] = this.typeStatus;
    data['commodities'] = this.commodities != null?this.commodities.map((i) => i.toJson()).toList():null;
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
"commodities": [
{
"attachements": [
{
"attType": 1,
"createtime": 1536292707000,
"fkId": 27,
"id": 46,
"newName": "a5074a039a 2019-10-25 16:25:48.822 30345-30421/com.example.beyond_user.host I/flutter: 5443e8accd6b52675b6da2PP.png",
"oldName": "PP诱虫板",
"size": 0,
"suffix": ".png",
"type": 0,
"uri": "upload/a5074a039a5443e8accd6b52675b6da2PP.png"
}
],
"createId": 0,
"id": 27,
"name": "PP诱虫板",
"parentId": 0,
"recommend": 0,
"updateId": 0
},
{
"attachements": [
{
"attType": 1,
"createtime": 1536292798000,
"fkId": 28,
"id": 47,
"newName": "70539c156a8d4f76ada07b53413fd14b.png",
"oldName": "可降解诱虫板",
"size": 0,
"suffix": ".png",
"type": 0,
"uri": "upload/70539c156a8d4f76ada07b53413fd14b.png"
}
],
"createId": 0,
"id": 28,
"name": "可降解诱虫板",
"parentId": 0,
"recommend": 0,
"updateId": 0
},
{
"attachements": [
{
"attType": 1,
"createtime": 1536292982000,
"fkId": 29,
"id": 48,
"newName": "b798a3200ebb4cc58e72f45295ecc546.png",
"oldName": "诱蝇球",
"size": 0,
"suffix": ".png",
"type": 0,
"uri": "upload/b798a3200ebb4cc58e72f45295ecc546.png"
}
],
"createId": 0,
"id": 29,
"name": "诱蝇球",
"parentId": 0,
"recommend": 0,
"updateId": 0
}
],
"id": 2,
"typeName": "粘虫板",
"typeStatus": 0
}*/
