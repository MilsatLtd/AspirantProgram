class ForgotPasswordModel {
  String? email;
  String? profileType;
  String? nonFieldError;

  ForgotPasswordModel({this.email, this.profileType, this.nonFieldError});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    profileType = json['profile_type'];
    nonFieldError = json['non_field_errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['profile_type'] = profileType;
    data['non_field_errors'] = nonFieldError;
    return data;
  }
}

class ForgotPasswordResponse {
  String? message;
  List? profileType;
  List? nonFieldErrors;

  ForgotPasswordResponse({this.message, this.profileType, this.nonFieldErrors});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    profileType = json['profile_type'];
    nonFieldErrors = json['non_field_errors'];
  }
}
