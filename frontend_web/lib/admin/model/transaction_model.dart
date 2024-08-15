// To parse this JSON data, do
//
//     final transactions = transactionsFromMap(jsonString);

import 'dart:convert';

Transactions transactionsFromMap(String str) =>
    Transactions.fromMap(json.decode(str));

String transactionsToMap(Transactions data) => json.encode(data.toMap());

class Transactions {
  bool? error;
  String? message;
  List<Transaction>? transactions;

  Transactions({
    this.error,
    this.message,
    this.transactions,
  });

  factory Transactions.fromMap(Map<String, dynamic> json) => Transactions(
        error: json["error"],
        message: json["message"],
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toMap())),
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
  User? user;

  Transaction({
    this.id,
    this.classId,
    this.createdAt,
    this.uniqueCode,
    this.paymentStatus,
    this.expired,
    this.userId,
    this.transactionClass,
    this.user,
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
        user: json["User"] == null ? null : User.fromMap(json["User"]),
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
        "User": user?.toMap(),
      };
}

class Class {
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
  String? address;
  int? maxParticipants;
  String? zoomLink;
  dynamic rejectReason;
  Mentor? mentor;

  Class({
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
    this.mentor,
  });

  factory Class.fromMap(Map<String, dynamic> json) => Class(
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
        mentor: json["mentor"] == null ? null : Mentor.fromMap(json["mentor"]),
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
        "rejectReason": rejectReason,
        "mentor": mentor?.toMap(),
      };
}

class Mentor {
  String? name;

  Mentor({
    this.name,
  });

  factory Mentor.fromMap(Map<String, dynamic> json) => Mentor(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
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
      };
}
