import 'package:dio/dio.dart';
import 'package:my_flutter_app/admin/model/unverified_transaction.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnverifiedTransactionService {
  final Dio _dio = Dio();

  Future<List<Transaction>> fetchUnverifiedTransactions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.get(
        '$baseUrl/admin/unverified-transaction',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming the response structure aligns with UnverifiedTransaction model
        final UnverifiedTransactionResponse =
            UnverifiedTransaction.fromMap(response.data);

        // Utilizing the error field from the UnverifiedTransaction response
        if (UnverifiedTransactionResponse.error == true) {
          throw Exception(
              'Error fetching unverified transactions: ${UnverifiedTransactionResponse.message}');
        }

        return UnverifiedTransactionResponse.transactions ?? [];
      } else {
        throw Exception(
            'Failed to load unverified transactions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error or handle it in a way that's appropriate for your application
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<void> verifyTransaction(String transactionId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.patch(
        '$baseUrl/admin/verify-transaction',
        data: {
          'transactionId': transactionId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to verify transaction. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error or handle it in a way that's appropriate for your application
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<void> rejectTransaction(
      String transactionId, String rejectReason) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.patch(
        '$baseUrl/admin/reject-transaction',
        data: {
          'transactionId': transactionId,
          'rejectReason': rejectReason,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Reject class success : ${response.data}");
      } else {
        throw Exception(
            'Failed to reject class. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("Error: $e");
    }
  }
}
