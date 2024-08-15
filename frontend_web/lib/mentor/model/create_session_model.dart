class CreateSessionModels {
  final String title;
  final String description;
  final String category;
  final DateTime dateTime;
  final DateTime startTime;
  final DateTime endTime;
  final int maxParticipants;

  CreateSessionModels({
    required this.title,
    required this.description,
    required this.category,
    required this.dateTime,
    required this.startTime,
    required this.endTime,
    required this.maxParticipants,
  });

 Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'category': category,
    'dateTime': dateTime.toIso8601String(),
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
    'maxParticipants': maxParticipants,
  };
}