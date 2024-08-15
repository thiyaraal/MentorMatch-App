import 'package:dio/dio.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseRoleService {
  Dio dio = Dio();

  Future<void> chooseRole(String selectedRole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? token = prefs.getString('token');

    if (userId == null || token == null) {
      print("User ID or Token not found");
      return;
    }

    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.patch(
        '$baseUrl/users/$userId/select-role',
        data: {'selectedRole': selectedRole},
      );

      if (response.statusCode == 200) {
        print("Role selected successfully: ${response.data}");
      } else {
        print("Error selecting role: ${response.statusCode}");
      }
    } on DioError catch (e) {
      print("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("Error: $e");
    }
  }
}
