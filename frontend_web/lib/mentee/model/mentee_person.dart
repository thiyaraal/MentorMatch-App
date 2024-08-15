// To parse this JSON data, do
//
//     final menteeModel = menteeModelFromMap(jsonString);

import 'dart:convert';

MenteeModel menteeModelFromMap(String str) =>
    MenteeModel.fromMap(json.decode(str));

String menteeModelToMap(MenteeModel data) => json.encode(data.toMap());

class MenteeModel {
  bool? error;
  String? message;
  List<Mentee>? mentees;

  MenteeModel({
    this.error,
    this.message,
    this.mentees,
  });

  factory MenteeModel.fromMap(Map<String, dynamic> json) => MenteeModel(
        error: json["error"],
        message: json["message"],
        mentees: json["mentees"] == null
            ? []
            : List<Mentee>.from(json["mentees"]!.map((x) => Mentee.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "mentees": mentees == null
            ? []
            : List<dynamic>.from(mentees!.map((x) => x.toMap())),
      };
}

class Mentee {
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
  List<dynamic>? communities;
  dynamic menteeClass;
  List<dynamic>? session;
  List<dynamic>? participant;
  List<Transaction>? transactions;
  List<Experience>? experiences;

  Mentee({
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
    this.communities,
    this.menteeClass,
    this.session,
    this.participant,
    this.transactions,
    this.experiences,
  });

  factory Mentee.fromMap(Map<String, dynamic> json) => Mentee(
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
        communities: json["communities"] == null
            ? []
            : List<dynamic>.from(json["communities"]!.map((x) => x)),
        menteeClass: json["class"],
        session: json["session"] == null
            ? []
            : List<dynamic>.from(json["session"]!.map((x) => x)),
        participant: json["participant"] == null
            ? []
            : List<dynamic>.from(json["participant"]!.map((x) => x)),
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromMap(x))),
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
        "communities": communities == null
            ? []
            : List<dynamic>.from(communities!.map((x) => x)),
        "class": menteeClass,
        "session":
            session == null ? [] : List<dynamic>.from(session!.map((x) => x)),
        "participant": participant == null
            ? []
            : List<dynamic>.from(participant!.map((x) => x)),
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toMap())),
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

class Transaction {
  String? id;
  String? classId;
  String? createdAt;
  int? uniqueCode;
  String? paymentStatus;
  String? expired;
  String? userId;

  Transaction({
    this.id,
    this.classId,
    this.createdAt,
    this.uniqueCode,
    this.paymentStatus,
    this.expired,
    this.userId,
  });

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        classId: json["classId"],
        createdAt: json["createdAt"],
        uniqueCode: json["uniqueCode"],
        paymentStatus: json["paymentStatus"],
        expired: json["expired"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "classId": classId,
        "createdAt": createdAt,
        "uniqueCode": uniqueCode,
        "paymentStatus": paymentStatus,
        "expired": expired,
        "userId": userId,
      };
}
