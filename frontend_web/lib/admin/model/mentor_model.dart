// To parse this JSON data, do
//
//     final mentors = mentorsFromMap(jsonString);

import 'dart:convert';

Mentors mentorsFromMap(String str) => Mentors.fromMap(json.decode(str));

String mentorsToMap(Mentors data) => json.encode(data.toMap());

class Mentors {
  bool? error;
  String? message;
  List<Mentor>? mentors;

  Mentors({
    this.error,
    this.message,
    this.mentors,
  });

  factory Mentors.fromMap(Map<String, dynamic> json) => Mentors(
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
  String? accountNumber;
  String? accountName;
  dynamic rejectReason;
  List<Experience>? experiences;
  List<Class>? mentorClass;
  List<Session>? session;
  List<MentorReview>? mentorReviews;

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
    this.mentorClass,
    this.session,
    this.mentorReviews,
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
        mentorClass: json["class"] == null
            ? []
            : List<Class>.from(json["class"]!.map((x) => Class.fromMap(x))),
        session: json["session"] == null
            ? []
            : List<Session>.from(
                json["session"]!.map((x) => Session.fromMap(x))),
        mentorReviews: json["mentorReviews"] == null
            ? []
            : List<MentorReview>.from(
                json["mentorReviews"]!.map((x) => MentorReview.fromMap(x))),
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
        "class": mentorClass == null
            ? []
            : List<dynamic>.from(mentorClass!.map((x) => x.toMap())),
        "session": session == null
            ? []
            : List<dynamic>.from(session!.map((x) => x.toMap())),
        "mentorReviews": mentorReviews == null
            ? []
            : List<dynamic>.from(mentorReviews!.map((x) => x.toMap())),
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

class Class {
  String? name;
  bool? isVerified;

  Class({
    this.name,
    this.isVerified,
  });

  factory Class.fromMap(Map<String, dynamic> json) => Class(
        name: json["name"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "isVerified": isVerified,
      };
}

class MentorReview {
  String? id;
  String? reviewerId;
  String? mentorId;
  String? content;
  Reviewer? reviewer;

  MentorReview({
    this.id,
    this.reviewerId,
    this.mentorId,
    this.content,
    this.reviewer,
  });

  factory MentorReview.fromMap(Map<String, dynamic> json) => MentorReview(
        id: json["id"],
        reviewerId: json["reviewerId"],
        mentorId: json["mentorId"],
        content: json["content"],
        reviewer: json["reviewer"] == null
            ? null
            : Reviewer.fromMap(json["reviewer"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "reviewerId": reviewerId,
        "mentorId": mentorId,
        "content": content,
        "reviewer": reviewer?.toMap(),
      };
}

class Reviewer {
  String? name;

  Reviewer({
    this.name,
  });

  factory Reviewer.fromMap(Map<String, dynamic> json) => Reviewer(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}

class Session {
  String? title;
  bool? isActive;

  Session({
    this.title,
    this.isActive,
  });

  factory Session.fromMap(Map<String, dynamic> json) => Session(
        title: json["title"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "isActive": isActive,
      };
}
