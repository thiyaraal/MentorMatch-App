
import 'package:dio/dio.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningMaterialService {
  Dio _dio = Dio();


  Future<String> createLearningMaterial(String classId, String title, String link) async {
    // Mendapatkan token dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    // Pastikan token tersedia
    if(token == null) {
      return "Error: User is not logged in.";
    }
    
    // Endpoint untuk create learning material
    String url = "$baseUrl/class/$classId/learning-material";

    try {
      final response = await _dio.post(url,
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
        return "Learning material created successfully";
      } else {
        // Menghandle error dengan menampilkan pesan dari server jika ada
        var data = response.data;
        return "Error: ${data['message'] ?? 'Failed to create learning material'}";
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        // Menghandle error dengan menampilkan pesan dari server jika ada
        var data = e.response!.data;
        return "Error: ${data['message'] ?? 'Failed to create learning material'}";
      } else {
        // Error ketika tidak ada response dari server
        return "Error: ${e.message}";
      }
    }
  }
}
