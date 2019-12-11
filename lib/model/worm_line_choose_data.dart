class WormLineChooseData {
  List<CropsListBean> crops;
  List<DevicesListBean> devices;
  List<InsectTypesListBean> insectTypes;
  List<PrincipalsListBean> principals;
  List<StagesListBean> stages;

  WormLineChooseData({this.crops, this.devices, this.insectTypes, this.principals, this.stages});

  WormLineChooseData.fromJson(Map<String, dynamic> json) {    
    this.crops = (json['crops'] as List)!=null?(json['crops'] as List).map((i) => CropsListBean.fromJson(i)).toList():null;
    this.devices = (json['devices'] as List)!=null?(json['devices'] as List).map((i) => DevicesListBean.fromJson(i)).toList():null;
    this.insectTypes = (json['insectTypes'] as List)!=null?(json['insectTypes'] as List).map((i) => InsectTypesListBean.fromJson(i)).toList():null;
    this.principals = (json['principals'] as List)!=null?(json['principals'] as List).map((i) => PrincipalsListBean.fromJson(i)).toList():null;
    this.stages = (json['stages'] as List)!=null?(json['stages'] as List).map((i) => StagesListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crops'] = this.crops != null?this.crops.map((i) => i.toJson()).toList():null;
    data['devices'] = this.devices != null?this.devices.map((i) => i.toJson()).toList():null;
    data['insectTypes'] = this.insectTypes != null?this.insectTypes.map((i) => i.toJson()).toList():null;
    data['principals'] = this.principals != null?this.principals.map((i) => i.toJson()).toList():null;
    data['stages'] = this.stages != null?this.stages.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class CropsListBean {
  String code;
  String value;

  CropsListBean({this.code, this.value});

  CropsListBean.fromJson(Map<String, dynamic> json) {    
    this.code = json['code'];
    this.value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['value'] = this.value;
    return data;
  }
}

class DevicesListBean {
  String code;
  String value;

  DevicesListBean({this.code, this.value});

  DevicesListBean.fromJson(Map<String, dynamic> json) {    
    this.code = json['code'];
    this.value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['value'] = this.value;
    return data;
  }
}

class InsectTypesListBean {
  String code;
  String value;

  InsectTypesListBean({this.code, this.value});

  InsectTypesListBean.fromJson(Map<String, dynamic> json) {    
    this.code = json['code'];
    this.value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['value'] = this.value;
    return data;
  }
}

class PrincipalsListBean {
  String code;
  String value;

  PrincipalsListBean({this.code, this.value});

  PrincipalsListBean.fromJson(Map<String, dynamic> json) {    
    this.code = json['code'];
    this.value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['value'] = this.value;
    return data;
  }
}

class StagesListBean {
  String code;
  String value;

  StagesListBean({this.code, this.value});

  StagesListBean.fromJson(Map<String, dynamic> json) {    
    this.code = json['code'];
    this.value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['value'] = this.value;
    return data;
  }
}
