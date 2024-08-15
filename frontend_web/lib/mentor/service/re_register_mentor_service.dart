import 'package:dio/dio.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentorUpdateService {
  Dio dio = Dio();

  Future<void> updateMentor({
    required String mentorId,
    required String gender,
    required String job,
    required String company,
    required String location,
    required List<String> skills,
    required String linkedin,
    required String portfolio,
    required String about,
    required String accountNumber,
    required String accountName,
    required List<Map<String, dynamic>> experiences,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final userId = prefs.getString('userId') ?? '';

    // Ensure headers are correctly set
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await dio.patch(
        "$baseUrl/users/mentor/$userId/register-update",
        data: {
          "mentorId": mentorId,
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
        },
      );

      if (response.statusCode == 200) {
        print("Profile updated successfully: ${response.data}");
      } else {
        print("Error updating profile: HTTP status ${response.statusCode}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        print("Dio error without response: ${e.response}");
      }
    } catch (e) {
      print("Unexpected error: $e");
    }
  }
}
