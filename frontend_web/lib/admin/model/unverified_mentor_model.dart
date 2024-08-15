// To parse this JSON data, do
//
//     final unverifiedMentor = unverifiedMentorFromMap(jsonString);

import 'dart:convert';

UnverifiedMentor unverifiedMentorFromMap(String str) =>
    UnverifiedMentor.fromMap(json.decode(str));

String unverifiedMentorToMap(UnverifiedMentor data) =>
    json.encode(data.toMap());

class UnverifiedMentor {
  bool? error;
  String? message;
  List<Mentor>? mentors;

  UnverifiedMentor({
    this.error,
    this.message,
    this.mentors,
  });

  factory UnverifiedMentor.fromMap(Map<String, dynamic> json) =>
      UnverifiedMentor(
        error: json["error"],
        message: json["message"],
        mentors: json["mentors"] == null
            ? []
            : List<Mentor>.from(json["mentors"]!.map((x) => Mentor.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "mentors": mentors == null
            ? []
            : List<dynamic>.from(mentors!.map((x) => x.toMap())),
      };
}

class Mentor {
  String? id;
  String? userType;
  String? email;
  String? name;
  List<String>? skills;
  String? gender;
  String? location;
  String? linkedin;
  String? portofolio;
  String? photoUrl;
  String? about;
  dynamic accountNumber;
  dynamic accountName;
  dynamic rejectReason;
  List<Experience>? experiences;

  Mentor({
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

  factory Mentor.fromMap(Map<String, dynamic> json) => Mentor(
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
            : List<Experience>.from(
                json["experiences"]!.map((x) => Experience.fromMap(x))),
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

class Experience {
  String? id;
  String? userId;
  bool? isCurrentJob;
  String? company;
  String? jobTitle;

  Experience({
    this.id,
    this.userId,
    this.isCurrentJob,
    this.company,
    this.jobTitle,
  });

  factory Experience.fromMap(Map<String, dynamic> json) => Experience(
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
