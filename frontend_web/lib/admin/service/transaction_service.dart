import 'package:dio/dio.dart';
import 'package:my_flutter_app/admin/model/transaction_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  final Dio _dio = Dio();

  Future<List<Transaction>> fetchTransactions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) throw Exception('Token not found');

      final Response response = await _dio.get(
        '$baseUrl/admin/list-transaction',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming the response structure aligns with Transactions model
        final transactions = Transactions.fromMap(response.data);

        // Utilizing the error field from the Transactions response
        if (transactions.error == true) {
          throw Exception(
              'Error fetching transactions: ${transactions.message}');
        }

        return transactions.transactions ?? [];
      } else {
        throw Exception(
            'Failed to load transactions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
