// To parse this JSON data, do
//
//     final session = sessionFromMap(jsonString);

import 'dart:convert';

Session sessionFromMap(String str) => Session.fromMap(json.decode(str));

String sessionToMap(Session data) => json.encode(data.toMap());

class Session {
  bool? error;
  String? message;
  List<MentorSession>? mentors;

  Session({
    this.error,
    this.message,
    this.mentors,
  });

  factory Session.fromMap(Map<String, dynamic> json) => Session(
        error: json["error"],
        message: json["message"],
        mentors: json["mentors"] == null
            ? []
            : List<MentorSession>.from(json["mentors"]!.map((x) => MentorSession.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "mentors": mentors == null
            ? []
            : List<dynamic>.from(mentors!.map((x) => x.toMap())),
      };
}

class MentorSession {
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
  List<SessionElement>? session;
  List<Experience>? experiences;
  List<MentorReview>? mentorReviews;

  MentorSession({
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
    this.session,
    this.experiences,
    this.mentorReviews,
  });

  factory MentorSession.fromMap(Map<String, dynamic> json) => MentorSession(
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
        session: json["session"] == null
            ? []
            : List<SessionElement>.from(
                json["session"]!.map((x) => SessionElement.fromMap(x))),
        experiences: json["experiences"] == null
            ? []
            : List<Experience>.from(
                json["experiences"]!.map((x) => Experience.fromMap(x))),
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
        "session": session == null
            ? []
            : List<dynamic>.from(session!.map((x) => x.toMap())),
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences!.map((x) => x.toMap())),
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

class MentorReview {
  String? id;
  String? reviewerId;
  String? mentorId;
  String? content;
  String? reviewer;

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
        reviewer: json["reviewer"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "reviewerId": reviewerId,
        "mentorId": mentorId,
        "content": content,
        "reviewer": reviewer,
      };
}

class SessionElement {
  String? id;
  String? mentorId;
  String? title;
  String? description;
  String? category;
  String? dateTime;
  String? startTime;
  String? endTime;
  int? maxParticipants;
  bool? isActive;
  dynamic zoomLink;
  List<dynamic>? participant;

  SessionElement({
    this.id,
    this.mentorId,
    this.title,
    this.description,
    this.category,
    this.dateTime,
    this.startTime,
    this.endTime,
    this.maxParticipants,
    this.isActive,
    this.zoomLink,
    this.participant,
  });

  factory SessionElement.fromMap(Map<String, dynamic> json) => SessionElement(
        id: json["id"],
        mentorId: json["mentorId"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        dateTime: json["dateTime"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        maxParticipants: json["maxParticipants"],
        isActive: json["isActive"],
        zoomLink: json["zoomLink"],
        participant: json["participant"] == null
            ? []
            : List<dynamic>.from(json["participant"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "mentorId": mentorId,
        "title": title,
        "description": description,
        "category": category,
        "dateTime": dateTime,
        "startTime": startTime,
        "endTime": endTime,
        "maxParticipants": maxParticipants,
        "isActive": isActive,
        "zoomLink": zoomLink,
        "participant": participant == null
            ? []
            : List<dynamic>.from(participant!.map((x) => x)),
      };
}
