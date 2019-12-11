class User {
  String accessToken;
  String tokenType;
  String refreshToken;
  String scope;
  String jti;
  int expiresIn;

  User({this.accessToken, this.tokenType, this.refreshToken, this.scope, this.jti, this.expiresIn});

  User.fromJson(Map<String, dynamic> json) {    
    this.accessToken = json['access_token'];
    this.tokenType = json['token_type'];
    this.refreshToken = json['refresh_token'];
    this.scope = json['scope'];
    this.jti = json['jti'];
    this.expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['refresh_token'] = this.refreshToken;
    data['scope'] = this.scope;
    data['jti'] = this.jti;
    data['expires_in'] = this.expiresIn;
    return data;
  }

}
