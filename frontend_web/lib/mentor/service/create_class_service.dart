import 'package:dio/dio.dart';
import 'package:my_flutter_app/Mentor/model/create_class_models.dart';
import 'package:my_flutter_app/style/baseURl.dart';


class CreateClassService {
  Dio _dio = Dio();
  

  CreateClassService() {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      // Tambahkan header lain jika diperlukan, seperti Authorization
    };
  }

  Future<Response<dynamic>> createClass(
      CreateClassModels classModel, String mentorId) async {
    try {
      final response = await _dio.post(
        '$baseUrl/mentor/$mentorId/class',
        data: classModel.toJson(),
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
      if (e.response != null && e.response!.data != null && e.response!.data['message'] != null) {
        return e.response!;
      }
      throw Exception('Failed to create class');
    }
  }
}
