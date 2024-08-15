import 'package:dio/dio.dart';
import 'package:my_flutter_app/mentee/model/my_class_model.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';
import 'package:my_flutter_app/style/baseURl.dart';

class BookingService {
  final Dio _dio = Dio();

  Future<List<ParticipantMyClass>> fetchUserSessions() async {
    try {
      final userId = UserPreferences.getUserId();
      if (userId != null) {
        final response = await _dio.get('$baseUrl/users/$userId/my-class');
        if (response.statusCode == 200) {
          final List<dynamic> sessionDataList =
              response.data['user']['participant'];
          return sessionDataList
              .map((data) => ParticipantMyClass.fromMap(data))
              .toList();
        } else {
          throw Exception('Failed to load user sessions');
        }
      } else {
        throw Exception('User ID not found');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<List<TransactionMyClass>> fetchUserTransactions() async {
    try {
      final userId = UserPreferences.getUserId();
      if (userId != null) {
        final response = await _dio.get('$baseUrl/users/$userId/my-class');
        if (response.statusCode == 200) {
          final List<dynamic> transactionDataList =
              response.data['user']['transactions'];
          return transactionDataList
              .map((data) => TransactionMyClass.fromMap(data))
              .toList();
        } else {
          throw Exception('Failed to load user transactions');
        }
      } else {
        throw Exception('User ID not found');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
