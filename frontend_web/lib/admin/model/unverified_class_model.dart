// To parse this JSON data, do
//
//     final unverifiedClass = unverifiedClassFromMap(jsonString);

import 'dart:convert';

UnverifiedClass unverifiedClassFromMap(String str) =>
    UnverifiedClass.fromMap(json.decode(str));

String unverifiedClassToMap(UnverifiedClass data) => json.encode(data.toMap());

class UnverifiedClass {
  bool? error;
  String? message;
  List<Class>? classes;

  UnverifiedClass({
    this.error,
    this.message,
    this.classes,
  });

  factory UnverifiedClass.fromMap(Map<String, dynamic> json) => UnverifiedClass(
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
  dynamic zoomLink;
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
