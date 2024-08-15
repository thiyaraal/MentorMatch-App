import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/category_kuliah_model.dart';
import 'package:mentormatch_apps/style/base_url.dart';

class KuliahServices {
  final Dio _dio = Dio();

  // KuliahServices() {
  //   // Menambahkan token ke header default untuk semua permintaan
  //   _dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IkplcmVteWxld2lAZ21haWwuY29tIiwiaWF0IjoxNzA3MDQ5MzQxfQ.mEg7JJACQbYgaDxYpQaGDZfi92Ks_NmeQ-ZPvpOt3ks';
  // }

  Future<KuliahNew> getKuliahData() async {
    try {
      final response = await _dio.get('$baseUrl/class/filter-mentors?educationLevel=Kuliah&category');
      if (response.statusCode == 200) {
        return KuliahNew.fromMap(response.data);
      } else {
        throw Exception('Failed to load Kuliah data');
      }
    } catch (error) {
      print('Error fetching Kuliah data: $error');
      throw error;
    }
  }
}
