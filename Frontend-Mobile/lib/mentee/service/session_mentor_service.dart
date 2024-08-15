import 'package:dio/dio.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/style/base_url.dart';


class SessionServices {
  final Dio _dio = Dio();

  Future<Session> getSessionData() async {
    try {
      final response =
          await _dio.get('$baseUrl/session/filter-mentors?category');
      if (response.statusCode == 200) {
        return Session.fromMap(response.data);
      } else {
        throw Exception('Failed to load Session data');
      }
    } catch (error) {
      print('Error fetching Session data: $error');
      throw error;
    }
  }

   Future<List<MentorSession>> fetchAvailableMentors() async {
    try {
      final response = await _dio.get('$baseUrl/session/filter-mentors?available=true');
      if (response.statusCode == 200) {
        return (response.data['mentors'] as List)
            .map((mentor) => MentorSession.fromMap(mentor))
            .toList();
      } else {
        throw Exception('Failed to load available mentors');
      }
    } catch (error) {
      print('Error fetching available mentors: $error');
      throw error;
    }
  }
}