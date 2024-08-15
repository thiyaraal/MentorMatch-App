import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/category_SMP_model.dart';
import 'package:mentormatch_apps/style/base_url.dart';

class SMPServices {
  final Dio _dio = Dio();

  SMPServices() {
    // Menambahkan token ke header default untuk semua permintaan
    _dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IkplcmVteWxld2lAZ21haWwuY29tIiwiaWF0IjoxNzA3MDQ5MzQxfQ.mEg7JJACQbYgaDxYpQaGDZfi92Ks_NmeQ-ZPvpOt3ks';
  }

  Future<SMP> getSMPData() async {
    try {
      final response = await _dio.get('$baseUrl/class/filter-mentors?educationLevel=SMP&category');
      if (response.statusCode == 200) {
        return SMP.fromMap(response.data);
      } else {
        throw Exception('Failed to load SMP data');
      }
    } catch (error) {
      print('Error fetching SMP data: $error');
      throw error;
    }
  }
}
