// To parse this JSON data, do
//
//     final listClass = listClassFromMap(jsonString);

import 'dart:convert';

ListClass listClassFromMap(String str) => ListClass.fromMap(json.decode(str));

String listClassToMap(ListClass data) => json.encode(data.toMap());

class ListClass {
  bool? error;
  String? message;
  List<Class>? classes;

  ListClass({
    this.error,
    this.message,
    this.classes,
  });

  factory ListClass.fromMap(Map<String, dynamic> json) => ListClass(
        error: json["error"],
        message: json["message"],
        classes: json["classes"] == null
            ? []
            : List<Class>.from(json["classes"]!.map((x) => Class.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "classes": classes == null
            ? []
            : List<dynamic>.from(classes!.map((x) => x.toMap())),
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
  String? rejectReason;
  Mentor? mentor;
  List<Transaction>? transactions;

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
    this.transactions,
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
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromMap(x))),
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
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toMap())),
      };
}

class Mentor {
  String? name;
  String? photoUrl;

  Mentor({
    this.name,
    this.photoUrl,
  });

  factory Mentor.fromMap(Map<String, dynamic> json) => Mentor(
        name: json["name"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "photoUrl": photoUrl,
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
  User? user;

  Transaction({
    this.id,
    this.classId,
    this.createdAt,
    this.uniqueCode,
    this.paymentStatus,
    this.expired,
    this.userId,
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
        "User": user?.toMap(),
      };
}

class User {
  String? name;

  User({
    this.name,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
