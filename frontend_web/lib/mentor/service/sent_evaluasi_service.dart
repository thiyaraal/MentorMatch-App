import 'package:dio/dio.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendEvaluasiService {
  Dio _dio = Dio();

  Future<String> sendEvaluationLink(
      String classId, String topic, String link) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print("Token tidak ditemukan");
      return "Token tidak ditemukan. Silakan login kembali.";
    }

    String url = "$baseUrl/class/$classId/evaluation";
    try {
      final response = await _dio.post(
        url,
        data: {
          "topic": topic,
          "link": link,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

       if (response.statusCode == 200) {
        // Feedback berhasil dikirim maka tampilkan messege
        return "Evaluasi berhasil dikirim.";
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