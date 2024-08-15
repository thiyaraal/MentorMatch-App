import 'package:dio/dio.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterMentorService {
  Dio dio = Dio(); // Create Dio instance

  Future<void> registerMentor({
    required String gender,
    required String job,
    required String company,
    required List<String> skills,
    required String location,
    required String about,
    required String linkedin,
    required String portofolio,
    required String accountName,
    required String accountNumber,
    required List<Map<String, String>> experiences,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('userId') ?? '';

    // Ensure headers are correctly set
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await dio.patch(
        '$baseUrl/users/mentor/$id/register', // Make sure this endpoint is correct
        data: {
          'gender': gender,
          'job': job,
          'company': company,
          'skills': skills,
          'location': location,
          'about': about,
          'linkedin': linkedin,
          'portofolio': portofolio,
          'experiences': experiences,
          'accountName': accountName,
          'accountNumber': accountNumber,
        },
      );

      if (response.statusCode == 200) {
        print("Profile updated successfully: ${response.data}");
      } else {
        // Use more specific error handling here to capture and log the status code
        print("Error updating profile: HTTP status ${response.statusCode}");
      }
    } on DioError catch (e) {
      // Enhanced error handling for more specific feedback
      if (e.response != null) {
        print("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        print("Dio error without response: ${e.message}");
      }
    } catch (e) {
      print("Unexpected error: $e");
    }
  }
}
