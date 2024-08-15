// To parse this JSON data, do
//
//     final kuliah = kuliahFromMap(jsonString);

import 'dart:convert';

KuliahNew kuliahFromMap(String str) => KuliahNew.fromMap(json.decode(str));

String kuliahToMap(KuliahNew data) => json.encode(data.toMap());

class KuliahNew {
    bool? error;
    String? message;
    List<MentorKuliah>? mentors;

    KuliahNew({
        this.error,
        this.message,
        this.mentors,
    });

    factory KuliahNew.fromMap(Map<String, dynamic> json) => KuliahNew(
        error: json["error"],
        message: json["message"],
        mentors: json["mentors"] == null ? [] : List<MentorKuliah>.from(json["mentors"]!.map((x) => MentorKuliah.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "mentors": mentors == null ? [] : List<dynamic>.from(mentors!.map((x) => x.toMap())),
    };
}

class MentorKuliah {
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
    List<ClassMentorKuliah>? mentorClass;
    List<MentorReviewKuliah>? mentorReviews;
    List<ExperienceKuliah>? experiences;

    MentorKuliah({
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

    factory MentorKuliah.fromMap(Map<String, dynamic> json) => MentorKuliah(
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
        mentorClass: json["class"] == null ? [] : List<ClassMentorKuliah>.from(json["class"]!.map((x) => ClassMentorKuliah.fromMap(x))),
        mentorReviews: json["mentorReviews"] == null ? [] : List<MentorReviewKuliah>.from(json["mentorReviews"]!.map((x) => MentorReviewKuliah.fromMap(x))),
        experiences: json["experiences"] == null ? [] : List<ExperienceKuliah>.from(json["experiences"]!.map((x) => ExperienceKuliah.fromMap(x))),
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

class ExperienceKuliah {
    String? id;
    String? userId;
    bool? isCurrentJob;
    String? company;
    String? jobTitle;

    ExperienceKuliah({
        this.id,
        this.userId,
        this.isCurrentJob,
        this.company,
        this.jobTitle,
    });

    factory ExperienceKuliah.fromMap(Map<String, dynamic> json) => ExperienceKuliah(
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

class ClassMentorKuliah {
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
    List<TransactionKuliah>? transactions;

    ClassMentorKuliah({
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

    factory ClassMentorKuliah.fromMap(Map<String, dynamic> json) => ClassMentorKuliah(
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
        transactions: json["transactions"] == null ? [] : List<TransactionKuliah>.from(json["transactions"]!.map((x) => TransactionKuliah.fromMap(x))),
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

class TransactionKuliah {
    String? id;
    String? classId;
    String? createdAt;
    int? uniqueCode;
    String? paymentStatus;
    String? expired;
    String? userId;

    TransactionKuliah({
        this.id,
        this.classId,
        this.createdAt,
        this.uniqueCode,
        this.paymentStatus,
        this.expired,
        this.userId,
    });

    factory TransactionKuliah.fromMap(Map<String, dynamic> json) => TransactionKuliah(
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

class MentorReviewKuliah {
    String? id;
    String? reviewerId;
    String? mentorId;
    String? content;
    String? reviewer;

    MentorReviewKuliah({
        this.id,
        this.reviewerId,
        this.mentorId,
        this.content,
        this.reviewer,
    });

    factory MentorReviewKuliah.fromMap(Map<String, dynamic> json) => MentorReviewKuliah(
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
