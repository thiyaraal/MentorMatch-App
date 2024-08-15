import 'package:dio/dio.dart';
import 'package:my_flutter_app/mentor/model/my_class_mentor_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';

import '../../preferences/ preferences_helper.dart';

class ListClassMentor {
  final Dio _dio = Dio();

  Future<List<Session>> fetchSessionsForCurrentUser() async {
    final userId = UserPreferences.getUserId();
    try {
      final response = await _dio.get('$baseUrl/users/$userId/my-class');
      if (response.statusCode == 200) {
        // Deserialize JSON ke MyClassMentorModel
        MyClassMentorMondel model = MyClassMentorMondel.fromMap(response.data);

        // Cek jika user dan session tidak null
        if (model.user != null && model.user!.session != null) {
          // Langsung return list session yang sudah ada
          return model.user!.session!;
        } else {
          throw Exception("Session data not found");
        }
      } else {
        throw Exception("Failed to load sessions");
      }
    } catch (e) {
      print(e); // Gunakan logging yang sesuai
      throw Exception("Failed to load sessions: $e");
    }
  }

  Future<MyClassMentorMondel> fetchClassData() async {
    // Here we get the userId directly inside the service method
    final userId = UserPreferences.getUserId();
    try {
      final response = await _dio.get('$baseUrl/users/$userId/my-class');
      if (response.statusCode == 200) {
        return MyClassMentorMondel.fromMap(response.data);
      } else {
        throw Exception("Failed to load class data");
      }
    } catch (e) {
      throw Exception("Failed to load class data: $e");
    }
  }

  // Future<List<AllClass>> fetchClassesForCurrentUser() async {
  //   final userId = UserPreferences.getUserId();
  //   try {
  //     final response = await _dio.get('$baseUrl/users/$userId/my-class');
  //     if (response.statusCode == 200) {
  //       MyClassMentorMondel model = MyClassMentorMondel.fromMap(response.data);
  //       if (model.user != null && model.user!.userClass != null) {
  //         return model.user!.userClass!;
  //       } else {
  //         throw Exception("Class data not found");
  //       }
  //     } else {
  //       throw Exception("Failed to load classes");
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw Exception("Failed to load classes: $e");
  //   }
  // }
}
