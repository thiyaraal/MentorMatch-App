import 'package:dio/dio.dart';
import 'package:my_flutter_app/admin/model/unverified_mentor_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnverifiedMentorService {
  final Dio _dio = Dio();

  Future<List<Mentor>> fetchUnverifiedMentors() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.get(
        '$baseUrl/admin/unverified-mentor',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming the response structure aligns with UnverifiedMentor model
        final UnverifiedMentorResponse =
            UnverifiedMentor.fromMap(response.data);

        // Utilizing the error field from the UnverifiedMentor response
        if (UnverifiedMentorResponse.error == true) {
          throw Exception(
              'Error fetching unverified mentors: ${UnverifiedMentorResponse.message}');
        }

        return UnverifiedMentorResponse.mentors ?? [];
      } else {
        throw Exception(
            'Failed to load unverified mentors. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error or handle it in a way that's appropriate for your application
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<void> verifyMentor(String mentorId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.patch(
        '$baseUrl/admin/verify-mentor',
        data: {
          'mentorId': mentorId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Verify mentor success : ${response.data}");
      } else {
        throw Exception(
            'Failed to verify mentor. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> rejectMentor(String mentorId, String rejectReason) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.patch(
        '$baseUrl/admin/reject-mentor',
        data: {
          'mentorId': mentorId,
          'rejectReason': rejectReason,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Reject mentor success : ${response.data}");
      } else {
        throw Exception(
            'Failed to reject mentor. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("Error: $e");
    }
  }
}
