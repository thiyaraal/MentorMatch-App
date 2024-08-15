import 'package:dio/dio.dart';
import 'package:my_flutter_app/style/baseURl.dart';

class ReviewService {
  final Dio _dio = Dio();

  Future<String> sendReview(
      String content, String userId, String mentorId) async {
    try {
      final response = await _dio.post("$baseUrl/mentee/$userId/review", data: {
        "mentorId": mentorId,
        "userId":
            userId, // Pastikan konsistensi nama kunci sesuai dengan backend
        "content": content,
      });

      if (response.statusCode == 200) {
        // Respons 200 OK, asumsikan review berhasil dikirim
        // Mengembalikan pesan sukses dari server atau pesan default
        return response.data['message'] ?? "Review berhasil dikirim.";
      } else {
        // Respons tidak sesuai ekspektasi, melempar exception dengan pesan error dari server
        final message = response.data['message'] ?? 'Gagal mengirim review';
        throw Exception(message);
      }
      // ignore: deprecated_member_use
    } on DioError catch (dioError) {
      // Menangkap error dari Dio dan melempar kembali exception dengan pesan error dari server atau default
      final errorMessage = dioError.response?.data['message'] ??
          'Terjadi kesalahan saat mengirim review';
      throw Exception(errorMessage);
    } catch (e) {
      // Menangkap error umum lainnya dan melempar kembali sebagai exception
      throw Exception("Error: ${e.toString()}");
    }
  }
}
