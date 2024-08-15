import 'package:dio/dio.dart';
import 'package:my_flutter_app/mentee/service/bookingClassService/bookclass_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';

Future<BookingResultClass> bookClass(String classId, String userId) async {
  var dio = Dio();

  try {
    final response = await dio.post(
      '$baseUrl/class/$classId/book',
      data: {'userId': userId},
    );

    // Jika request berhasil dan mendapatkan respons
    if (response.statusCode == 200 && response.data != null) {
      int? uniqueCode = response.data['booking']['uniqueCode'] != null
          ? int.tryParse(response.data['booking']['uniqueCode'].toString())
          : null;
      // Cetak unique code jika ada
      print('Unique code: $uniqueCode');

      // Mengembalikan hasil booking dengan isSuccess true dan pesan dari server
      return BookingResultClass(
          isSuccess: true,
          uniqueCode: uniqueCode,
          message: response.data['message'] ?? "Booking successful");
    } else {
      // Jika response tidak sesuai, kembalikan isSuccess false dan pesan error
      return BookingResultClass(
          isSuccess: false,
          message: response.data['message'] ?? "Failed to book class");
    }
  } on DioError catch (e) {
    // Menangkap error dari Dio dan mengembalikan hasil dengan pesan error
    String errorMessage = e.response != null
        ? e.response!.data['message']
        : "Error booking session";
    return BookingResultClass(isSuccess: false, message: errorMessage);
  } catch (e) {
    print(e.toString());
    // Jika terjadi error lain
    return BookingResultClass(
        isSuccess: false, message: "Error booking session");
  }
}
