import 'package:dio/dio.dart';
import 'package:my_flutter_app/mentor/model/create_session_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';

class CreateSessionService {
  Dio _dio = Dio();

  CreateSessionService() {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      // Add other headers if necessary, such as Authorization
    };
  }

  Future<Response<dynamic>> createSession(
      CreateSessionModels sessionModel, String mentorId) async {
    try {
      final response = await _dio.post(
        '$baseUrl/mentor/$mentorId/session',
        data: sessionModel.toJson(),
      );
      if (response.statusCode == 200) {
        print('Class created successfully: ${response.data}');
        return response;
      } else {
        String errorMessage = 'Failed to create class';
        if (response.data != null && response.data['message'] != null) {
          errorMessage += ': ${response.data['message']}';
        }
        print(errorMessage);
        throw Exception(errorMessage);
      }
    } on DioError catch (e) {
      print('Error creating class: ${e.message}');
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['message'] != null) {
        return e.response!;
      }
      throw Exception('Failed to create class');
    }
  }
}
