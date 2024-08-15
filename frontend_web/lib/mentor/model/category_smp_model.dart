// To parse this JSON data, do
//
//     final smp = smpFromMap(jsonString);

import 'dart:convert';

SMP smpFromMap(String str) => SMP.fromMap(json.decode(str));

String smpToMap(SMP data) => json.encode(data.toMap());

class SMP {
  bool? error;
  String? message;
  List<MentorSMP>? mentors;

  SMP({
    this.error,
    this.message,
    this.mentors,
  });

  factory SMP.fromMap(Map<String, dynamic> json) => SMP(
        error: json["error"],
        message: json["message"],
        mentors: json["mentors"] == null
            ? []
            : List<MentorSMP>.from(
                json["mentors"]!.map((x) => MentorSMP.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "mentors": mentors == null
            ? []
            : List<dynamic>.from(mentors!.map((x) => x.toMap())),
      };
}

class MentorSMP {
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
  List<ClassMentorSMP>? mentorClass;
  List<dynamic>? mentorReviews;
  List<ExperienceSMP>? experiences;

  MentorSMP({
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
    this.mentorClass,
      this.rejectReason,
    this.mentorReviews,
    this.experiences,
  });

  factory MentorSMP.fromMap(Map<String, dynamic> json) => MentorSMP(
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
        mentorClass: json["class"] == null
            ? []
            : List<ClassMentorSMP>.from(
                json["class"]!.map((x) => ClassMentorSMP.fromMap(x))),
        mentorReviews: json["mentorReviews"] == null
            ? []
            : List<dynamic>.from(json["mentorReviews"]!.map((x) => x)),
        experiences: json["experiences"] == null
            ? []
            : List<ExperienceSMP>.from(
                json["experiences"]!.map((x) => ExperienceSMP.fromMap(x))),
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
        "class": mentorClass == null
            ? []
            : List<dynamic>.from(mentorClass!.map((x) => x.toMap())),
        "mentorReviews": mentorReviews == null
            ? []
            : List<dynamic>.from(mentorReviews!.map((x) => x)),
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences!.map((x) => x.toMap())),
      };
}

class ExperienceSMP {
  String? id;
  String? userId;
  bool? isCurrentJob;
  String? company;
  String? jobTitle;

  ExperienceSMP({
    this.id,
    this.userId,
    this.isCurrentJob,
    this.company,
    this.jobTitle,
  });

  factory ExperienceSMP.fromMap(Map<String, dynamic> json) => ExperienceSMP(
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

class ClassMentorSMP {
  String? id;
  String? mentorId;
  String? educationLevel;
  String? category;
  String? name;
  String? description;
  List<String>? terms;
  List<String>? targetLearning;
  int? price;
  bool? isActive;
  bool? isAvailable;
  bool? isVerified;
  String? startDate;
  String? endDate;
  String? schedule;
  int? durationInDays;
  String? location;
  dynamic address;
  int? maxParticipants;
  dynamic zoomLink;
  dynamic rejectReason;
  List<TransactionSMP>? transactions;

  ClassMentorSMP({
    this.id,
    this.mentorId,
    this.educationLevel,
    this.category,
    this.name,
    this.description,
    this.terms,
    this.targetLearning,
    this.price,
    this.isActive,
    this.isAvailable,
    this.isVerified,
    this.startDate,
    this.endDate,
    this.schedule,
    this.durationInDays,
    this.location,
    this.address,
    this.maxParticipants,
    this.zoomLink,
    this.rejectReason,
    this.transactions,
  });

  factory ClassMentorSMP.fromMap(Map<String, dynamic> json) => ClassMentorSMP(
        id: json["id"],
        mentorId: json["mentorId"],
        educationLevel: json["educationLevel"],
        category: json["category"],
        name: json["name"],
        description: json["description"],
        terms: json["terms"] == null
            ? []
            : List<String>.from(json["terms"]!.map((x) => x)),
        targetLearning: json["targetLearning"] == null
            ? []
            : List<String>.from(json["targetLearning"]!.map((x) => x)),
        price: json["price"],
        isActive: json["isActive"],
        isAvailable: json["isAvailable"],
        isVerified: json["isVerified"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        schedule: json["schedule"],
        durationInDays: json["durationInDays"],
        location: json["location"],
        address: json["address"],
        maxParticipants: json["maxParticipants"],
        zoomLink: json["zoomLink"],
        rejectReason: json["rejectReason"],
        transactions: json["transactions"] == null
            ? []
            : List<TransactionSMP>.from(
                json["transactions"]!.map((x) => TransactionSMP.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "mentorId": mentorId,
        "educationLevel": educationLevel,
        "category": category,
        "name": name,
        "description": description,
        "terms": terms == null ? [] : List<dynamic>.from(terms!.map((x) => x)),
        "targetLearning": targetLearning == null
            ? []
            : List<dynamic>.from(targetLearning!.map((x) => x)),
        "price": price,
        "isActive": isActive,
        "isAvailable": isAvailable,
        "isVerified": isVerified,
        "startDate": startDate,
        "endDate": endDate,
        "schedule": schedule,
        "durationInDays": durationInDays,
        "location": location,
        "address": address,
        "maxParticipants": maxParticipants,
        "zoomLink": zoomLink,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toMap())),
      };
}

class TransactionSMP {
  String? id;
  String? classId;
  String? createdAt;
  int? uniqueCode;
  String? paymentStatus;
  String? expired;
  String? userId;

  TransactionSMP({
    this.id,
    this.classId,
    this.createdAt,
    this.uniqueCode,
    this.paymentStatus,
    this.expired,
    this.userId,
  });

  factory TransactionSMP.fromMap(Map<String, dynamic> json) => TransactionSMP(
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

class MentorReviewSMP {
  String? id;
  String? reviewerId;
  String? mentorId;
  String? content;
  String? reviewer;

  MentorReviewSMP({
    this.id,
    this.reviewerId,
    this.mentorId,
    this.content,
    this.reviewer,
  });

  factory MentorReviewSMP.fromMap(Map<String, dynamic> json) => MentorReviewSMP(
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
