import 'package:dio/dio.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackService {
  static Future<dynamic> sendFeedback(
      String evaluationId, String menteeId, String content, int result) async {
    Dio dio = Dio();

    // Dapatkan token dari SharedPreferences, jika autentikasi diperlukan
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await dio.post("$baseUrl/feedback",
          data: {
            'evaluationId': evaluationId,
            'menteeId': menteeId,
            'content': content,
            'result': result,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'Bearer $token', // Sertakan token jika diperlukan
            },
          ));

      if (response.statusCode == 200) {
        // Feedback berhasil dikirim
        return null;
      } else {
        // Gagal mengirim feedback, baca dan kembalikan pesan error dari backend
        return response.data['message'] ??
            'Terjadi kesalahan yang tidak diketahui.';
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null) {
        // Gagal karena respons dari server, baca dan kembalikan pesan error dari backend
        return e.response!.data['message'] ??
            'Terjadi kesalahan yang tidak diketahui.';
      } else {
        // Gagal karena alasan lain, seperti kesalahan jaringan atau konfigurasi
        return 'Gagal mengirim feedback: ${e.message}';
      }
    } catch (e) {
      // Tangkap exception lain dan kembalikan sebagai pesan error
      return 'Gagal mengirim feedback: ${e.toString()}';
    }
  }
}

