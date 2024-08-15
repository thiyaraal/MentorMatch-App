// To parse this JSON data, do
//
//     final myClassMentorMondel = myClassMentorMondelFromMap(jsonString);

import 'dart:convert';

MyClassMentorMondel myClassMentorMondelFromMap(String str) =>
    MyClassMentorMondel.fromMap(json.decode(str));

String myClassMentorMondelToMap(MyClassMentorMondel data) =>
    json.encode(data.toMap());

class MyClassMentorMondel {
  bool? error;
  String? message;
  User? user;

  MyClassMentorMondel({
    this.error,
    this.message,
    this.user,
  });

  factory MyClassMentorMondel.fromMap(Map<String, dynamic> json) =>
      MyClassMentorMondel(
        error: json["error"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "user": user?.toMap(),
      };
}

class User {
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
  List<AllClass>? userClass;
  List<Session>? session;
  List<dynamic>? transactions;
  List<dynamic>? participant;
  List<dynamic>? mentorReviews;

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
    this.experiences,
    this.userClass,
    this.session,
    this.transactions,
    this.participant,
    this.mentorReviews,
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
        experiences: json["experiences"] == null
            ? []
            : List<Experience>.from(
                json["experiences"]!.map((x) => Experience.fromMap(x))),
        userClass: json["class"] == null
            ? []
            : List<AllClass>.from(json["class"]!.map((x) => AllClass.fromMap(x))),
        session: json["session"] == null
            ? []
            : List<Session>.from(
                json["session"]!.map((x) => Session.fromMap(x))),
        transactions: json["transactions"] == null
            ? []
            : List<dynamic>.from(json["transactions"]!.map((x) => x)),
        participant: json["participant"] == null
            ? []
            : List<dynamic>.from(json["participant"]!.map((x) => x)),
        mentorReviews: json["mentorReviews"] == null
            ? []
            : List<dynamic>.from(json["mentorReviews"]!.map((x) => x)),
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
        "class": userClass == null
            ? []
            : List<dynamic>.from(userClass!.map((x) => x.toMap())),
        "session": session == null
            ? []
            : List<dynamic>.from(session!.map((x) => x.toMap())),
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x)),
        "participant": participant == null
            ? []
            : List<dynamic>.from(participant!.map((x) => x)),
        "mentorReviews": mentorReviews == null
            ? []
            : List<dynamic>.from(mentorReviews!.map((x) => x)),
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

class Session {
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

  Session({
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

  factory Session.fromMap(Map<String, dynamic> json) => Session(
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

class AllClass {
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
  List<LearningMaterialMentor>? learningMaterial;
  List<Evaluation>? evaluations;
  List<Transaction>? transactions;
  List<FeedbackMyClassMentor>? feedbacks;

  AllClass({
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
    this.learningMaterial,
    this.evaluations,
    this.transactions,
    this.feedbacks,
  });

  factory AllClass.fromMap(Map<String, dynamic> json) => AllClass(
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
        feedbacks: json["feedbacks"] == null
            ? []
            : List<FeedbackMyClassMentor>.from(json["feedbacks"]!
                .map((x) => FeedbackMyClassMentor.fromMap(x))),
        learningMaterial: json["learningMaterial"] == null
            ? []
            : List<LearningMaterialMentor>.from(json["learningMaterial"]!
                .map((x) => LearningMaterialMentor.fromMap(x))),
        evaluations: json["evaluations"] == null
            ? []
            : List<Evaluation>.from(
                json["evaluations"]!.map((x) => Evaluation.fromMap(x))),
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
        "feedbacks": feedbacks == null
            ? []
            : List<dynamic>.from(feedbacks!.map((x) => x.toMap())),
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
        "learningMaterial": learningMaterial == null
            ? []
            : List<dynamic>.from(learningMaterial!.map((x) => x.toMap())),
        "evaluations": evaluations == null
            ? []
            : List<dynamic>.from(evaluations!.map((x) => x.toMap())),
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toMap())),
      };
}

class Evaluation {
  String? id;
  String? classId;
  String? createdAt;
  String? topic;
  String? link;
  List<FeedbackMyClassMentor>? feedbacks;

  Evaluation({
    this.id,
    this.classId,
    this.createdAt,
    this.topic,
    this.link,
    this.feedbacks,
  });

  factory Evaluation.fromMap(Map<String, dynamic> json) => Evaluation(
        id: json["id"],
        classId: json["classId"],
        createdAt: json["createdAt"],
        topic: json["topic"],
        link: json["link"],
        feedbacks: json["feedbacks"] == null
            ? []
            : List<FeedbackMyClassMentor>.from(json["feedbacks"]!
                .map((x) => FeedbackMyClassMentor.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "classId": classId,
        "createdAt": createdAt,
        "topic": topic,
        "link": link,
        "feedbacks": feedbacks == null
            ? []
            : List<dynamic>.from(feedbacks!.map((x) => x.toMap())),
      };
}

class FeedbackMyClassMentor {
  String? id;
  String? evaluationId;
  String? menteeId;
  String? content;
  int? result;

  FeedbackMyClassMentor({
    this.id,
    this.evaluationId,
    this.menteeId,
    this.content,
    this.result,
  });

  factory FeedbackMyClassMentor.fromMap(Map<String, dynamic> json) =>
      FeedbackMyClassMentor(
        id: json["id"],
        evaluationId: json["evaluationId"],
        menteeId: json["menteeId"],
        content: json["content"],
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "evaluationId": evaluationId,
        "menteeId": menteeId,
        "content": content,
        "result": result,
      };
}

class LearningMaterialMentor {
  String? id;
  String? classId;
  String? title;
  String? link;

  LearningMaterialMentor({
    this.id,
    this.classId,
    this.title,
    this.link,
  });

  factory LearningMaterialMentor.fromMap(Map<String, dynamic> json) =>
      LearningMaterialMentor(
        id: json["id"],
        classId: json["classId"],
        title: json["title"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "classId": classId,
        "title": title,
        "link": link,
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
  UserClass? user;

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
        user: json["User"] == null ? null : UserClass.fromMap(json["User"]),
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

class UserClass {
  String? name;

  UserClass({
    this.name,
  });

  factory UserClass.fromMap(Map<String, dynamic> json) => UserClass(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
