// To parse this JSON data, do
//
//     final mentees = menteesFromMap(jsonString);

import 'dart:convert';

Mentees menteesFromMap(String str) => Mentees.fromMap(json.decode(str));

String menteesToMap(Mentees data) => json.encode(data.toMap());

class Mentees {
  bool? error;
  String? message;
  List<Mentee>? mentees;

  Mentees({
    this.error,
    this.message,
    this.mentees,
  });

  factory Mentees.fromMap(Map<String, dynamic> json) => Mentees(
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
  dynamic accountNumber;
  dynamic accountName;
  dynamic rejectReason;
  List<Experience>? experiences;
  List<Transaction>? transactions;
  List<Participant>? participant;

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
    this.accountNumber,
    this.accountName,
    this.rejectReason,
    this.experiences,
    this.transactions,
    this.participant,
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
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        rejectReason: json["rejectReason"],
        experiences: json["experiences"] == null
            ? []
            : List<Experience>.from(
                json["experiences"]!.map((x) => Experience.fromMap(x))),
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromMap(x))),
        participant: json["participant"] == null
            ? []
            : List<Participant>.from(
                json["participant"]!.map((x) => Participant.fromMap(x))),
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
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toMap())),
        "participant": participant == null
            ? []
            : List<dynamic>.from(participant!.map((x) => x.toMap())),
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

class Participant {
  String? sessionId;
  String? userId;
  Session? session;

  Participant({
    this.sessionId,
    this.userId,
    this.session,
  });

  factory Participant.fromMap(Map<String, dynamic> json) => Participant(
        sessionId: json["sessionId"],
        userId: json["userId"],
        session:
            json["session"] == null ? null : Session.fromMap(json["session"]),
      );

  Map<String, dynamic> toMap() => {
        "sessionId": sessionId,
        "userId": userId,
        "session": session?.toMap(),
      };
}

class Session {
  String? title;

  Session({
    this.title,
  });

  factory Session.fromMap(Map<String, dynamic> json) => Session(
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
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
  Class? transactionClass;

  Transaction({
    this.id,
    this.classId,
    this.createdAt,
    this.uniqueCode,
    this.paymentStatus,
    this.expired,
    this.userId,
    this.transactionClass,
  });

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        classId: json["classId"],
        createdAt: json["createdAt"],
        uniqueCode: json["uniqueCode"],
        paymentStatus: json["paymentStatus"],
        expired: json["expired"],
        userId: json["userId"],
        transactionClass:
            json["class"] == null ? null : Class.fromMap(json["class"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "classId": classId,
        "createdAt": createdAt,
        "uniqueCode": uniqueCode,
        "paymentStatus": paymentStatus,
        "expired": expired,
        "userId": userId,
        "class": transactionClass?.toMap(),
      };
}

class Class {
  String? name;

  Class({
    this.name,
  });

  factory Class.fromMap(Map<String, dynamic> json) => Class(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
