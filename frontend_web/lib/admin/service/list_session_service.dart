import 'package:dio/dio.dart';
import 'package:my_flutter_app/admin/model/list_session_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListSessionService {
  final Dio _dio = Dio();

  Future<List<Session>> fetchSessions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.get(
        '$baseUrl/admin/list-session',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final listSessionResponse = ListSession.fromMap(response.data);

        if (listSessionResponse.error == true) {
          throw Exception(
              'Error fetching sessions: ${listSessionResponse.message}');
        }

        return listSessionResponse.sessions ?? [];
      } else {
        throw Exception(
            'Failed to load sessions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  // add zoom link

  Future<void> addZoomLink(String sessionId, String zoomLink) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.patch(
        '$baseUrl/admin/add-zoom-link-session',
        data: {
          'sessionId': sessionId,
          'zoomLink': zoomLink,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        if (data['error'] == true) {
          throw Exception('Error adding zoom link: ${data['message']}');
        }
      } else {
        throw Exception(
            'Failed to add zoom link. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
