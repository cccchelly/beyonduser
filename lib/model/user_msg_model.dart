class UserMsgModel {
  String password;
  String username;
  String realname;
  String address;
  String mobile;
  bool accountNonExpired;
  bool accountNonLocked;
  bool credentialsNonExpired;
  bool enabled;
  List<AuthoritiesListBean> authorities;

  UserMsgModel({this.password, this.username, this.realname, this.address, this.mobile, this.accountNonExpired, this.accountNonLocked, this.credentialsNonExpired, this.enabled, this.authorities});

  UserMsgModel.fromJson(Map<String, dynamic> json) {    
    this.password = json['password'];
    this.username = json['username'];
    this.realname = json['realname'];
    this.address = json['address'];
    this.mobile = json['mobile'];
    this.accountNonExpired = json['accountNonExpired'];
    this.accountNonLocked = json['accountNonLocked'];
    this.credentialsNonExpired = json['credentialsNonExpired'];
    this.enabled = json['enabled'];
    this.authorities = (json['authorities'] as List)!=null?(json['authorities'] as List).map((i) => AuthoritiesListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['username'] = this.username;
    data['realname'] = this.realname;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['accountNonExpired'] = this.accountNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['enabled'] = this.enabled;
    data['authorities'] = this.authorities != null?this.authorities.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class AuthoritiesListBean {
  String authority;

  AuthoritiesListBean({this.authority});

  AuthoritiesListBean.fromJson(Map<String, dynamic> json) {    
    this.authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authority'] = this.authority;
    return data;
  }
}
