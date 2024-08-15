class CreateClassModels {
  final String schedule;
  final String location;
  final String address;
  final int maxParticipants;
  final String educationLevel;
  final String category;
  final String name;
  final String description;
  final List<String> terms;
  final int price;
  final DateTime endDate;
  final DateTime startDate;
  final List<String> targetLearning;
  final int durationInDays;

  CreateClassModels({
    required this.address,
    required this.targetLearning,
    required this.maxParticipants,
    required this.schedule,
    required this.location,
    required this.endDate,
    required this.startDate,
    required this.educationLevel,
    required this.category,
    required this.name,
    required this.description,
    required this.terms,
    required this.price,
    required this.durationInDays,
  });

  Map<String, dynamic> toJson() => {
        'address': address,
        'targetLearning': targetLearning,
        'maxParticipants': maxParticipants,
        'schedule': schedule,
        'location': location,
        'endDate': endDate.toIso8601String(),
        'startDate': startDate.toIso8601String(),
        'educationLevel': educationLevel,
        'category': category,
        'name': name,
        'description': description,
        'terms': terms,
        'price': price,
        'durationInDays': durationInDays,
      };
}
