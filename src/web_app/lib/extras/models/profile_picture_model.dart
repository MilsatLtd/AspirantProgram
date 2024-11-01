class ProfilePictureResponse {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  int? gender;
  String? country;
  String? phoneNumber;
  String? bio;
  String? profilePicture;

  ProfilePictureResponse(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.country,
      this.phoneNumber,
      this.bio,
      this.profilePicture});

  ProfilePictureResponse.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gender = json['gender'];
    country = json['country'];
    phoneNumber = json['phone_number'];
    bio = json['bio'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['gender'] = gender;
    data['country'] = country;
    data['phone_number'] = phoneNumber;
    data['bio'] = bio;
    data['profile_picture'] = profilePicture;
    return data;
  }
}
