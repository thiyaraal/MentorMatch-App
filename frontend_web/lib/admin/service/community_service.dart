import 'package:dio/dio.dart';
import 'package:my_flutter_app/admin/model/community_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityService {
  final Dio _dio = Dio();

  Future<CommunityModels> fetchCommunities() async {
    try {
      final response = await _dio.get("$baseUrl/communities");
      return CommunityModels.fromMap(response.data);
    } catch (error) {
      throw Exception("Failed to fetch Communities: $error");
    }
  }

  Future<Community> createCommunity({
    required String name,
    required String link,
    required String imageUrl,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? userId = prefs.getString('userId');

      if (token == null) throw Exception('Token not found');

      final response = await _dio.post(
        "$baseUrl/admin/$userId/create-community",
        data: {
          "name": name,
          "link": link,
          "imageUrl": imageUrl,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return Community.fromMap(response.data);
    } catch (error) {
      throw Exception("Failed to create Community: $error");
    }
  }
}
