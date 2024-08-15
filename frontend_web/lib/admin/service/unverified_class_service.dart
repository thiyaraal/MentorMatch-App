import 'package:dio/dio.dart';
import 'package:my_flutter_app/admin/model/unverified_class_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnverifiedClassService {
  final Dio _dio = Dio();

  Future<List<Class>> fetchUnverifiedClasses() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.get(
        '$baseUrl/admin/unverified-class',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming the response structure aligns with UnverifiedClass model
        final unverifiedClassResponse = UnverifiedClass.fromMap(response.data);

        // Utilizing the error field from the UnverifiedClass response
        if (unverifiedClassResponse.error == true) {
          throw Exception(
              'Error fetching unverified classes: ${unverifiedClassResponse.message}');
        }

        return unverifiedClassResponse.classes ?? [];
        // return unverifiedClassResponse.classes ?? [];
      } else {
        throw Exception(
            'Failed to load unverified classes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error or handle it in a way that's appropriate for your application
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<void> verifyClass(String classId, String zoomLink) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.patch(
        '$baseUrl/admin/verify-class',
        data: {
          'classId': classId,
          'zoomLink': zoomLink,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Verify class success : ${response.data}");
      } else {
        throw Exception(
            'Failed to verify class. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> rejectClass(String classId, String rejectReason) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.patch(
        '$baseUrl/admin/reject-class',
        data: {
          'classId': classId,
          'rejectReason': rejectReason,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Reject class success : ${response.data}");
      } else {
        throw Exception(
            'Failed to reject class. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("Error: $e");
    }
  }
}
