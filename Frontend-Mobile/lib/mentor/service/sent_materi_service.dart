import 'package:dio/dio.dart';
import 'package:mentormatch_apps/style/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningMaterialService {
  Dio _dio = Dio();

  Future<String> createLearningMaterial(
      String classId, String title, String link) async {
    // Mendapatkan token dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // Pastikan token tersedia
    if (token == null) {
      return "Error: User is not logged in.";
    }

    // Endpoint untuk create learning material
    String url = "$baseUrl/class/$classId/learning-material";

    try {
      final response = await _dio.post(
        url,
        data: {
          "title": title,
          "link": link,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Learning material created successfully';
      } else {
        var data = response.data;
        return 'Error: ${data['message'] ?? 'Failed to create learning material'}';
      }
    } on DioError catch (e) {
      if (e.response != null) {
        int statusCode = e.response!.statusCode ?? 500;
        if (statusCode == 400) {
          return 'Error: ${e.response!.data['message'] ?? 'Invalid URL format or link is not accessible'}';
        } else {
          return 'Error: ${e.response!.data['message'] ?? 'Failed to create learning material'}';
        }
      } else {
        return 'Error: ${e.message}';
      }
    } catch (error) {
      return 'Error: ${error.toString()}';
    }
  }
}
