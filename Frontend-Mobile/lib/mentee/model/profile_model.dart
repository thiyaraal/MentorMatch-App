// To parse this JSON data, do
//
//     final menteeProfile = menteeProfileFromMap(jsonString);

import 'dart:convert';

MenteeProfile menteeProfileFromMap(String str) =>
    MenteeProfile.fromMap(json.decode(str));

String menteeProfileToMap(MenteeProfile data) => json.encode(data.toMap());

class MenteeProfile {
  bool? error;
  String? message;
  User? user;

  MenteeProfile({
    this.error,
    this.message,
    this.user,
  });

  factory MenteeProfile.fromMap(Map<String, dynamic> json) => MenteeProfile(
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
  List<ExperienceMentee>? experiences;

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
        experiences: json["experiences"] == null
            ? []
            : List<ExperienceMentee>.from(
                json["experiences"]!.map((x) => ExperienceMentee.fromMap(x))),
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
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences!.map((x) => x.toMap())),
      };
}

class ExperienceMentee {
  String? id;
  String? userId;
  bool? isCurrentJob;
  String? company;
  String? jobTitle;

  ExperienceMentee({
    this.id,
    this.userId,
    this.isCurrentJob,
    this.company,
    this.jobTitle,
  });

  factory ExperienceMentee.fromMap(Map<String, dynamic> json) => ExperienceMentee(
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
