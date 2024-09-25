class AspirantModelClass {
  String? fullName;
  String? email;
  String? bio;
  Mentor? mentor;
  Track? track;
  Cohort? cohort;
  dynamic profilePicture;
  int? progress;

  AspirantModelClass({
    this.fullName,
    this.email,
    this.bio,
    this.mentor,
    this.track,
    this.cohort,
    this.profilePicture,
    this.progress,
  });

  factory AspirantModelClass.fromJson(Map<String, dynamic> json) =>
      AspirantModelClass(
        fullName: json["full_name"],
        email: json["email"],
        bio: json["bio"],
        mentor: json["mentor"] == null ? null : Mentor.fromJson(json["mentor"]),
        track: json["track"] == null ? null : Track.fromJson(json["track"]),
        cohort: json["cohort"] == null ? null : Cohort.fromJson(json["cohort"]),
        profilePicture: json["profile_picture"],
        progress: json["progress"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "bio": bio,
        "mentor": mentor?.toJson(),
        "track": track?.toJson(),
        "cohort": cohort?.toJson(),
        "profile_picture": profilePicture,
        "progress": progress,
      };
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

  factory Cohort.fromJson(Map<String, dynamic> json) => Cohort(
        cohortId: json["cohort_id"],
        name: json["name"],
        cohortDuration: json["cohort_duration"],
      );

  Map<String, dynamic> toJson() => {
        "cohort_id": cohortId,
        "name": name,
        "cohort_duration": cohortDuration,
      };
}

class Mentor {
  String? mentorId;
  String? fullName;
  String? email;
  String? bio;
  String? profilePicture;

  Mentor({
    this.mentorId,
    this.fullName,
    this.email,
    this.bio,
    this.profilePicture,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        mentorId: json["mentor_id"],
        fullName: json["full_name"],
        email: json["email"],
        bio: json["bio"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "mentor_id": mentorId,
        "full_name": fullName,
        "email": email,
        "bio": bio,
        "profile_picture": profilePicture,
      };
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

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        trackId: json["track_id"],
        name: json["name"],
        enrolledCount: json["enrolled_count"],
      );

  Map<String, dynamic> toJson() => {
        "track_id": trackId,
        "name": name,
        "enrolled_count": enrolledCount,
      };
}
