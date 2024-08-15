import 'package:dio/dio.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';

import '../../style/baseURl.dart';

class ClassUpdateService {
  Dio dio = Dio();


  Future<String> updateClass({
    required String classId,
    required String educationLevel,
    required String category,
    required String name,
    required String description,
    required List<String> terms,
    required List<String> targetLearning,
    required int price,
    required int durationInDays,
    required String startDate,
    required String endDate,
    required String schedule,
    required String address,
    required String location,
    required int maxParticipants,
  }) async {
    // Ambil userId dari preferences
    final userId = await UserPreferences.getUserId();
    if (userId == null) {
      return "User ID tidak ditemukan.";
    }

    // URL sekarang menggunakan userId
    String url = "$baseUrl/mentor/$userId/class";

    try {
      Response response = await dio.patch(url, data: {
        "classId": classId,
        "educationLevel": educationLevel,
        "category": category,
        "name": name,
        "description": description,
        "terms": terms,
        "targetLearning": targetLearning,
        "price": price,
        "durationInDays": durationInDays,
        "startDate": startDate,
        "endDate": endDate,
        "schedule": schedule,
        "address": address,
        "location": location,
        "maxParticipants": maxParticipants,
      });

      if (response.statusCode == 200) {
        return "Kelas berhasil diperbarui.";
      } else {
        return "Error: ${response.data['message']}";
      }
    } on DioError catch (e) {
      return "Error: ${e.response?.data['message'] ?? e.message}";
    }
  }
}
