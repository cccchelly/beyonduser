
class LoginOldData {
  String userName;
  String token;
  String role;
  List<String> authority;

  LoginOldData({
    this.userName,
    this.token,
    this.role,
    this.authority,
  });

  factory LoginOldData.fromJson(Map<String, dynamic> json) => new LoginOldData(
    userName: json["userName"],
    token: json["token"],
    role: json["role"],
    authority: new List<String>.from(json["authority"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "token": token,
    "role": role,
    "authority": new List<dynamic>.from(authority.map((x) => x)),
  };
}