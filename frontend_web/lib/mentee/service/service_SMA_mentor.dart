import 'package:dio/dio.dart';
import 'package:my_flutter_app/mentee/model/category_sma_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';

class SMAServices {
  final Dio _dio = Dio();

  SMAServices() {
    // Menambahkan token ke header default untuk semua permintaan
    _dio.options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IkplcmVteWxld2lAZ21haWwuY29tIiwiaWF0IjoxNzA3MDQ5MzQxfQ.mEg7JJACQbYgaDxYpQaGDZfi92Ks_NmeQ-ZPvpOt3ks';
  }

  Future<SMA> getSMAData() async {
    try {
      final response = await _dio
          .get('$baseUrl/class/filter-mentors?educationLevel=SMA&category');
      if (response.statusCode == 200) {
        return SMA.fromMap(response.data);
      } else {
        throw Exception('Failed to load SMA data');
      }
    } catch (error) {
      print('Error fetching SD data: $error');
      throw error;
    }
  }
}
