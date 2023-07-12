class MentorData {
  String? fullName;
  String? email;
  String? bio;
  Track? track;
  Cohort? cohort;
  List<Mentee>? mentees;
  dynamic profilePicture;

  MentorData({
    this.fullName,
    this.email,
    this.bio,
    this.track,
    this.cohort,
    this.mentees,
    this.profilePicture,
  });

  MentorData.fromJson(Map<String, dynamic> json) {
    fullName = json["full_name"];
    email = json["email"];
    bio = json["bio"];
    track = json["track"] == null ? null : Track.fromJson(json["track"]);
    cohort = json["cohort"] == null ? null : Cohort.fromJson(json["cohort"]);
    mentees = json["mentees"] == null
        ? []
        : List<Mentee>.from(json["mentees"]!.map((x) => Mentee.fromJson(x)));
    profilePicture = json["profile_picture"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["full_name"] = fullName;
    data["email"] = email;
    data["bio"] = bio;
    data["track"] = track?.toJson();
    data["cohort"] = cohort?.toJson();
    data["mentees"] = mentees == null
        ? []
        : List<dynamic>.from(mentees!.map((x) => x.toJson()));
    data["profile_picture"] = profilePicture;
    return data;
  }
}

class Cohort {
  String? cohortId;
  String? name;
  int? cohortDuration;

  Cohort({
    this.cohortId,
    this.name,
    this.cohortDuration,
  });

  Cohort.fromJson(Map<String, dynamic> json) {
    cohortId = json["cohort_id"];
    name = json["name"];
    cohortDuration = json["cohort_duration"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["cohort_id"] = cohortId;
    data["name"] = name;
    data["cohort_duration"] = cohortDuration;
    return data;
  }
}

class Mentee {
  String? userId;
  String? fullName;
  String? profilePicture;
  String? email;
  String? bio;

  Mentee({
    this.userId,
    this.fullName,
    this.profilePicture,
    this.email,
    this.bio,
  });

  Mentee.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"];
    fullName = json["full_name"];
    profilePicture = json["profile_picture"];
    email = json["email"];
    bio = json["bio"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_id"] = userId;
    data["full_name"] = fullName;
    data["profile_picture"] = profilePicture;
    data["email"] = email;
    data["bio"] = bio;
    return data;
  }
}

class Track {
  String? trackId;
  String? name;
  int? enrolledCount;

  Track({
    this.trackId,
    this.name,
    this.enrolledCount,
  });

  Track.fromJson(Map<String, dynamic> json) {
    trackId = json['track_id'];
    name = json['name'];
    enrolledCount = json['enrolled_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["track_id"] = trackId;
    data["name"] = name;
    data['enrolled_count'] = enrolledCount;
    return data;
  }
}
