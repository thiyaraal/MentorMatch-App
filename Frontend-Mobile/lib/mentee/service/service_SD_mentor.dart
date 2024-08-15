import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/category_SD_model.dart';
import 'package:mentormatch_apps/style/base_url.dart';

class SDServices {
  final Dio _dio = Dio();

  Future<SD> getSDData() async {
    try {
      final response = await _dio.get('$baseUrl/class/filter-mentors?educationLevel=SD&category');
      if (response.statusCode == 200) {
        return SD.fromMap(response.data);
      } else {
        throw Exception('Failed to load SD data');
      }
    } catch (error) {
      print('Error fetching SD data: $error');
      throw error;
    }
  }
}
