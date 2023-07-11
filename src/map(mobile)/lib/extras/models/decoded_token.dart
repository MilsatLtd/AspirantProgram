class DecodedToken {
  String? tokenType;
  String? exp;
  String? iat;
  String? jti;
  String? userId;
  String? fullName;
  String? email;
  int? role;

  DecodedToken({
    this.tokenType,
    this.exp,
    this.iat,
    this.jti,
    this.userId,
    this.fullName,
    this.email,
    this.role,
  });

  // DecodedToken.fromJson(Map<String, dynamic> json) {
  //   tokenType = json["student_id"];
  //   exp = json["question_1"];
  //   iat = json["question_2"];
  //   jti = json["question_3"];
  //   userId = json["full_name"];
  //   fullName = json["profile_picture"];
  //   email = json["report_id"];
  //   role = json["role"];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data["student_id"] = tokenType;
  //   data["question_1"] = exp;
  //   data["question_2"] = iat;
  //   data["question_3"] = jti;
  //   data["full_name"] = userId;
  //   data["profile_picture"] = fullName;
  //   data["report_id"] = email;
  //   data["role"] = role;
  //   return data;
  // }
}
