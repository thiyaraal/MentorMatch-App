// To parse this JSON data, do
//
//     final mentorProfile = mentorProfileFromMap(jsonString);

import 'dart:convert';

MentorProfile mentorProfileFromMap(String str) =>
    MentorProfile.fromMap(json.decode(str));

String mentorProfileToMap(MentorProfile data) => json.encode(data.toMap());

class MentorProfile {
  bool? error;
  String? message;
  User? user;

  MentorProfile({
    this.error,
    this.message,
    this.user,
  });

  factory MentorProfile.fromMap(Map<String, dynamic> json) => MentorProfile(
        error: json["error"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "user": user?.toMap(),
      };
}

class User {
  String? id;
  String? userType;
  String? email;
  String? name;
  List<String>? skills;
  dynamic gender;
  String? location;
  String? linkedin;
  dynamic portofolio;
  String? photoUrl;
  String? about;
  dynamic accountNumber;
  dynamic accountName;
  dynamic rejectReason;
  List<ExperienceMentor>? experiences;

  User({
    this.id,
    this.userType,
    this.email,
    this.name,
    this.skills,
    this.gender,
    this.location,
    this.linkedin,
    this.portofolio,
    this.photoUrl,
    this.about,
    this.accountNumber,
    this.accountName,
    this.rejectReason,
    this.experiences,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        userType: json["userType"],
        email: json["email"],
        name: json["name"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        gender: json["gender"],
        location: json["location"],
        linkedin: json["linkedin"],
        portofolio: json["portofolio"],
        photoUrl: json["photoUrl"],
        about: json["about"],
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        rejectReason: json["rejectReason"],
        experiences: json["experiences"] == null
            ? []
            : List<ExperienceMentor>.from(
                json["experiences"]!.map((x) => ExperienceMentor.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userType": userType,
        "email": email,
        "name": name,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "gender": gender,
        "location": location,
        "linkedin": linkedin,
        "portofolio": portofolio,
        "photoUrl": photoUrl,
        "about": about,
        "accountNumber": accountNumber,
        "accountName": accountName,
        "rejectReason": rejectReason,
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences!.map((x) => x.toMap())),
      };
}

class ExperienceMentor {
  String? id;
  String? userId;
  bool? isCurrentJob;
  String? company;
  String? jobTitle;

  ExperienceMentor({
    this.id,
    this.userId,
    this.isCurrentJob,
    this.company,
    this.jobTitle,
  });

  factory ExperienceMentor.fromMap(Map<String, dynamic> json) =>
      ExperienceMentor(
        id: json["id"],
        userId: json["userId"],
        isCurrentJob: json["isCurrentJob"],
        company: json["company"],
        jobTitle: json["jobTitle"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "isCurrentJob": isCurrentJob,
        "company": company,
        "jobTitle": jobTitle,
      };
}
