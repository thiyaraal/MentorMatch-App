// To parse this JSON data, do
//
//     final mentorClassModel = mentorClassModelFromMap(jsonString);

import 'dart:convert';

MentorClassModel mentorClassModelFromMap(String str) => MentorClassModel.fromMap(json.decode(str));

String mentorClassModelToMap(MentorClassModel data) => json.encode(data.toMap());

class MentorClassModel {
    bool? error;
    String? message;
    List<MentorClassAll>? mentors;

    MentorClassModel({
        this.error,
        this.message,
        this.mentors,
    });

    factory MentorClassModel.fromMap(Map<String, dynamic> json) => MentorClassModel(
        error: json["error"],
        message: json["message"],
        mentors: json["mentors"] == null ? [] : List<MentorClassAll>.from(json["mentors"]!.map((x) => MentorClassAll.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "mentors": mentors == null ? [] : List<dynamic>.from(mentors!.map((x) => x.toMap())),
    };
}

class MentorClassAll {
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
    List<ClassAll>? mentorClass;
    List<MentorReviewClassAll>? mentorReviews;
    List<ExperienceClassAll>? experiences;

    MentorClassAll({
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
        this.mentorReviews,
        this.experiences,
    });

    factory MentorClassAll.fromMap(Map<String, dynamic> json) => MentorClassAll(
        id: json["id"],
        userType: json["userType"],
        email: json["email"],
        name: json["name"],
        skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
        gender: json["gender"],
        location: json["location"],
        linkedin: json["linkedin"],
        portofolio: json["portofolio"],
        photoUrl: json["photoUrl"],
        about: json["about"],
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        mentorClass: json["class"] == null ? [] : List<ClassAll>.from(json["class"]!.map((x) => ClassAll.fromMap(x))),
        mentorReviews: json["mentorReviews"] == null ? [] : List<MentorReviewClassAll>.from(json["mentorReviews"]!.map((x) => MentorReviewClassAll.fromMap(x))),
        experiences: json["experiences"] == null ? [] : List<ExperienceClassAll>.from(json["experiences"]!.map((x) => ExperienceClassAll.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "userType": userType,
        "email": email,
        "name": name,
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "gender": gender,
        "location": location,
        "linkedin": linkedin,
        "portofolio": portofolio,
        "photoUrl": photoUrl,
        "about": about,
        "accountNumber": accountNumber,
        "accountName": accountName,
        "class": mentorClass == null ? [] : List<dynamic>.from(mentorClass!.map((x) => x.toMap())),
        "mentorReviews": mentorReviews == null ? [] : List<dynamic>.from(mentorReviews!.map((x) => x.toMap())),
        "experiences": experiences == null ? [] : List<dynamic>.from(experiences!.map((x) => x.toMap())),
    };
}

class ExperienceClassAll {
    String? id;
    String? userId;
    bool? isCurrentJob;
    String? company;
    String? jobTitle;

    ExperienceClassAll({
        this.id,
        this.userId,
        this.isCurrentJob,
        this.company,
        this.jobTitle,
    });

    factory ExperienceClassAll.fromMap(Map<String, dynamic> json) => ExperienceClassAll(
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

class ClassAll {
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
    List<TransactionClassAll>? transactions;

    ClassAll({
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
        this.transactions,
    });

    factory ClassAll.fromMap(Map<String, dynamic> json) => ClassAll(
        id: json["id"],
        mentorId: json["mentorId"],
        educationLevel: json["educationLevel"],
        category: json["category"],
        name: json["name"],
        description: json["description"],
        terms: json["terms"] == null ? [] : List<String>.from(json["terms"]!.map((x) => x)),
        targetLearning: json["targetLearning"] == null ? [] : List<String>.from(json["targetLearning"]!.map((x) => x)),
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
        transactions: json["transactions"] == null ? [] : List<TransactionClassAll>.from(json["transactions"]!.map((x) => TransactionClassAll.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "mentorId": mentorId,
        "educationLevel": educationLevel,
        "category": category,
        "name": name,
        "description": description,
        "terms": terms == null ? [] : List<dynamic>.from(terms!.map((x) => x)),
        "targetLearning": targetLearning == null ? [] : List<dynamic>.from(targetLearning!.map((x) => x)),
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
        "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toMap())),
    };
}

class TransactionClassAll {
    String? id;
    String? classId;
    String? createdAt;
    int? uniqueCode;
    String? paymentStatus;
    String? expired;
    String? userId;

    TransactionClassAll({
        this.id,
        this.classId,
        this.createdAt,
        this.uniqueCode,
        this.paymentStatus,
        this.expired,
        this.userId,
    });

    factory TransactionClassAll.fromMap(Map<String, dynamic> json) => TransactionClassAll(
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

class MentorReviewClassAll {
    String? id;
    String? reviewerId;
    String? mentorId;
    String? content;
    String? reviewer;

    MentorReviewClassAll({
        this.id,
        this.reviewerId,
        this.mentorId,
        this.content,
        this.reviewer,
    });

    factory MentorReviewClassAll.fromMap(Map<String, dynamic> json) => MentorReviewClassAll(
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