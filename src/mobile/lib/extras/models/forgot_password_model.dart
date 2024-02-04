class ForgotPasswordModel {
  String? email;
  String? profileType;

  ForgotPasswordModel({this.email, this.profileType});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    profileType = json['profile_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['profile_type'] = profileType;
    return data;
  }
}
