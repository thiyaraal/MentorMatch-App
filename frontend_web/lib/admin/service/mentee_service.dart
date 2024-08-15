import 'package:dio/dio.dart';
import 'package:my_flutter_app/admin/model/mentee_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenteeService {
  final Dio _dio = Dio();

// fetch  all mentee
  Future<List<Mentee>> fetchMentees() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.get(
        '$baseUrl/admin/list-mentee',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final menteeResponse = Mentees.fromMap(response.data);

        if (menteeResponse.error == true) {
          throw Exception('Error fetching mentees: ${menteeResponse.message}');
        }

        return menteeResponse.mentees ?? [];
      } else {
        throw Exception(
            'Failed to load mentees. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }

    // return [];
  }
}
