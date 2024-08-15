// To parse this JSON data, do
//
//     final myClassModel = myClassModelFromMap(jsonString);

import 'dart:convert';

MyClassModelMentee myClassModelFromMap(String str) =>
    MyClassModelMentee.fromMap(json.decode(str));

String myClassModelToMap(MyClassModelMentee data) => json.encode(data.toMap());

class MyClassModelMentee {
  bool? error;
  String? message;
  UserMyClass? user;

  MyClassModelMentee({
    this.error,
    this.message,
    this.user,
  });

  factory MyClassModelMentee.fromMap(Map<String, dynamic> json) =>
      MyClassModelMentee(
        error: json["error"],
        message: json["message"],
        user: json["user"] == null ? null : UserMyClass.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "user": user?.toMap(),
      };
}

class UserMyClass {
  String? id;
  String? userType;
  String? email;
  String? name;
  List<dynamic>? skills;
  dynamic gender;
  dynamic location;
  dynamic linkedin;
  dynamic portofolio;
  String? photoUrl;
  dynamic about;
  dynamic accountNumber;
  dynamic accountName;
   dynamic rejectReason;

  List<dynamic>? experiences;
  List<dynamic>? userClass;
  List<dynamic>? session;
  List<TransactionMyClass>? transactions;
  List<ParticipantMyClass>? participant;
  List<dynamic>? mentorReviews;

  UserMyClass({
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

  factory UserMyClass.fromMap(Map<String, dynamic> json) => UserMyClass(
        id: json["id"],
        userType: json["userType"],
        email: json["email"],
        name: json["name"],
        skills: json["skills"] == null
            ? []
            : List<dynamic>.from(json["skills"]!.map((x) => x)),
        gender: json["gender"],
        location: json["location"],
        linkedin: json["linkedin"],
        portofolio: json["portofolio"],
        photoUrl: json["photoUrl"],
        about: json["about"],
         rejectReason: json["rejectReason"],
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        experiences: json["experiences"] == null
            ? []
            : List<dynamic>.from(json["experiences"]!.map((x) => x)),
        userClass: json["class"] == null
            ? []
            : List<dynamic>.from(json["class"]!.map((x) => x)),
        session: json["session"] == null
            ? []
            : List<dynamic>.from(json["session"]!.map((x) => x)),
        transactions: json["transactions"] == null
            ? []
            : List<TransactionMyClass>.from(json["transactions"]!
                .map((x) => TransactionMyClass.fromMap(x))),
        participant: json["participant"] == null
            ? []
            : List<ParticipantMyClass>.from(
                json["participant"]!.map((x) => ParticipantMyClass.fromMap(x))),
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
            : List<dynamic>.from(experiences!.map((x) => x)),
        "class": userClass == null
            ? []
            : List<dynamic>.from(userClass!.map((x) => x)),
        "session":
            session == null ? [] : List<dynamic>.from(session!.map((x) => x)),
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toMap())),
        "participant": participant == null
            ? []
            : List<dynamic>.from(participant!.map((x) => x.toMap())),
        "mentorReviews": mentorReviews == null
            ? []
            : List<dynamic>.from(mentorReviews!.map((x) => x)),
      };
}

class ParticipantMyClass {
  String? sessionId;
  String? userId;
  SessionMyClass? session;

  ParticipantMyClass({
    this.sessionId,
    this.userId,
    this.session,
  });

  factory ParticipantMyClass.fromMap(Map<String, dynamic> json) =>
      ParticipantMyClass(
        sessionId: json["sessionId"],
        userId: json["userId"],
        session: json["session"] == null
            ? null
            : SessionMyClass.fromMap(json["session"]),
      );

  Map<String, dynamic> toMap() => {
        "sessionId": sessionId,
        "userId": userId,
        "session": session?.toMap(),
      };
}

class SessionMyClass {
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
  Mentor? mentor;

  SessionMyClass({
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
    this.mentor,
  });

  factory SessionMyClass.fromMap(Map<String, dynamic> json) => SessionMyClass(
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
        mentor: json["mentor"] == null ? null : Mentor.fromMap(json["mentor"]),
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
        "mentor": mentor?.toMap(),
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

class TransactionMyClass {
  String? id;
  String? classId;
  String? createdAt;
  int? uniqueCode;
  String? paymentStatus;
  String? expired;
     String? rejectReason;
  String? userId;
  ClassMyClass? transactionClass;

  TransactionMyClass({
    this.id,
    this.classId,
    this.createdAt,
    this.uniqueCode,
         this.rejectReason,
    this.paymentStatus,
    this.expired,
    this.userId,
    this.transactionClass,
  });

  factory TransactionMyClass.fromMap(Map<String, dynamic> json) =>
      TransactionMyClass(
        id: json["id"],
        classId: json["classId"],
        createdAt: json["createdAt"],
        uniqueCode: json["uniqueCode"],
        
        paymentStatus: json["paymentStatus"],
        expired: json["expired"],
        userId: json["userId"],
                rejectReason: json["rejectReason"],
        transactionClass:
            json["class"] == null ? null : ClassMyClass.fromMap(json["class"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "classId": classId,
        "createdAt": createdAt,
        "uniqueCode": uniqueCode,
        "paymentStatus": paymentStatus,
                "rejectReason": rejectReason,
        "expired": expired,
        "userId": userId,
        "class": transactionClass?.toMap(),
      };
}

class ClassMyClass {
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
  Mentor? mentor;
  List<EvaluationMyClass>? evaluations;
  List<LearningMaterialMyClass>? learningMaterial;

  ClassMyClass({
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
        this.rejectReason,
    this.location,
    this.address,
    this.maxParticipants,
    this.zoomLink,
    this.mentor,
    this.evaluations,
    this.learningMaterial,
  });

  factory ClassMyClass.fromMap(Map<String, dynamic> json) => ClassMyClass(
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
             rejectReason: json["rejectReason"],
        address: json["address"],
        maxParticipants: json["maxParticipants"],
        zoomLink: json["zoomLink"],
        mentor: json["mentor"] == null ? null : Mentor.fromMap(json["mentor"]),
        evaluations: json["evaluations"] == null
            ? []
            : List<EvaluationMyClass>.from(
                json["evaluations"]!.map((x) => EvaluationMyClass.fromMap(x))),
        learningMaterial: json["learningMaterial"] == null
            ? []
            : List<LearningMaterialMyClass>.from(json["learningMaterial"]!
                .map((x) => LearningMaterialMyClass.fromMap(x))),
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
          "rejectReason": rejectReason,
        "zoomLink": zoomLink,
        "mentor": mentor?.toMap(),
        "evaluations": evaluations == null
            ? []
            : List<dynamic>.from(evaluations!.map((x) => x.toMap())),
        "learningMaterial": learningMaterial == null
            ? []
            : List<dynamic>.from(learningMaterial!.map((x) => x.toMap())),
      };
}

class EvaluationMyClass {
  String? id;
  String? classId;
  String? createdAt;
  String? topic;
  String? link;
  List<Feedback>? feedbacks;

  EvaluationMyClass({
    this.id,
    this.classId,
    this.createdAt,
    this.topic,
    this.link,
    this.feedbacks,
  });

  factory EvaluationMyClass.fromMap(Map<String, dynamic> json) =>
      EvaluationMyClass(
        id: json["id"],
        classId: json["classId"],
        createdAt: json["createdAt"],
        topic: json["topic"],
        link: json["link"],
        feedbacks: json["feedbacks"] == null
            ? []
            : List<Feedback>.from(
                json["feedbacks"]!.map((x) => Feedback.fromMap(x))),
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

class Feedback {
  String? id;
  String? evaluationId;
  String? menteeId;
  String? content;
  int? result;

  Feedback({
    this.id,
    this.evaluationId,
    this.menteeId,
    this.content,
    this.result,
  });

  factory Feedback.fromMap(Map<String, dynamic> json) => Feedback(
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

class LearningMaterialMyClass {
  String? id;
  String? classId;
  String? title;
  String? link;

  LearningMaterialMyClass({
    this.id,
    this.classId,
    this.title,
    this.link,
  });

  factory LearningMaterialMyClass.fromMap(Map<String, dynamic> json) =>
      LearningMaterialMyClass(
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
