import 'dart:convert';

class DecodedTokenResponse {
  String? tokenType;
  int? exp;
  int? iat;
  String? jti;
  String? userId;
  String? fullName;
  String? email;
  int? role;

  DecodedTokenResponse(
      {this.tokenType,
      this.exp,
      this.iat,
      this.jti,
      this.userId,
      this.fullName,
      this.email,
      this.role});

  DecodedTokenResponse.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    exp = json['exp'];
    iat = json['iat'];
    jti = json['jti'];
    userId = json['user_id'];
    fullName = json['full_name'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token_type'] = tokenType;
    data['exp'] = exp;
    data['iat'] = iat;
    data['jti'] = jti;
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['email'] = email;
    data['role'] = role;
    return data;
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory DecodedTokenResponse.fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return DecodedTokenResponse.fromJson(jsonMap);
  }
}
