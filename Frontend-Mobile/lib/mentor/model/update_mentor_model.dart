class MentorUpdate {
  String gender;
  String job;
  String company;
  String location;
  List<String> skills;
  String linkedin;
  String portfolio;
  String about;
  String accountNumber;
  String accountName;
  List<Map<String, dynamic>> experiences;

  MentorUpdate({
    required this.gender,
    required this.job,
    required this.company,
    required this.location,
    required this.skills,
    required this.linkedin,
    required this.portfolio,
    required this.about,
    required this.accountNumber,
    required this.accountName,
    required this.experiences,
  });

  Map<String, dynamic> toJson() {
    return {
      "gender": gender,
      "job": job,
      "company": company,
      "location": location,
      "skills": skills,
      "linkedin": linkedin,
      "portofolio": portfolio,
      "about": about,
      "accountNumber": accountNumber,
      "accountName": accountName,
      "experiences": experiences,
    };
  }
}
