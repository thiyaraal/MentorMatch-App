// To parse this JSON data, do
//
//     final listSession = listSessionFromMap(jsonString);

import 'dart:convert';

ListSession listSessionFromMap(String str) =>
    ListSession.fromMap(json.decode(str));

String listSessionToMap(ListSession data) => json.encode(data.toMap());

class ListSession {
  bool? error;
  String? message;
  List<Session>? sessions;

  ListSession({
    this.error,
    this.message,
    this.sessions,
  });

  factory ListSession.fromMap(Map<String, dynamic> json) => ListSession(
        error: json["error"],
        message: json["message"],
        sessions: json["sessions"] == null
            ? []
            : List<Session>.from(
                json["sessions"]!.map((x) => Session.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "sessions": sessions == null
            ? []
            : List<dynamic>.from(sessions!.map((x) => x.toMap())),
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
  Mentor? mentor;

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
    this.mentor,
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
