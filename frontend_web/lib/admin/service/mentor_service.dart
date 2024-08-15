import 'package:dio/dio.dart';
import 'package:my_flutter_app/admin/model/mentor_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentorService {
  final Dio _dio = Dio();

// fetch  all mentors
  Future<List<Mentor>> fetchMentors() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.get(
        '$baseUrl/admin/list-mentor',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final mentorResponse = Mentors.fromMap(response.data);

        if (mentorResponse.error == true) {
          throw Exception('Error fetching mentors: ${mentorResponse.message}');
        }

        return mentorResponse.mentors ?? [];
      } else {
        throw Exception(
            'Failed to load mentors. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }

    // return [];
  }
}
