import 'package:dio/dio.dart';
import 'package:my_flutter_app/mentee/service/bookingClassService/bookclass_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';

// Future<BookingResultClass> bookSession(String sessionId, String userId) async {
//   var dio = Dio();

//   try {
//     final response = await dio.post(
//       '$baseUrl/session/$sessionId/book',
//       data: {'userId': userId},
//     );

//     if (response.statusCode == 200 && response.data != null) {
//       // Jika server merespons dengan "Session booked successfully"
//       if (!response.data['error']) {
//         return BookingResultClass(
//             isSuccess: true, message: response.data['message']);
//       } else {
//         // Jika server merespons dengan error (misal, "Session is already full")
//         return BookingResultClass(
//             isSuccess: false, message: response.data['message']);
//       }
//     } else {
//       // Jika status code bukan 200 atau response.data null
//       return BookingResultClass(
//           isSuccess: false, message: "Failed to book session");
//     }
//   } on DioError catch (e) {
//     // Jika terjadi DioError
//     String errorMessage = e.response != null
//         ? e.response!.data['message']
//         : "Error booking session";
//     return BookingResultClass(isSuccess: false, message: errorMessage);
//   } catch (e) {
//     print(e.toString());
//     // Jika terjadi error lain
//     return BookingResultClass(
//         isSuccess: false, message: "Error booking session");
//   }
// }

Future<BookingResultClass> bookSession(String sessionId, String userId) async {
  var dio = Dio();

  try {
    final response = await dio.post(
      '$baseUrl/session/$sessionId/book',
      data: {'userId': userId},
    );

    if (response.statusCode == 200) {
      if (response.data != null) {
        // Jika server merespons dengan "Session booked successfully"
        if (!response.data['error']) {
          return BookingResultClass(
              isSuccess: true, message: response.data['message']);
        } else {
          // Jika server merespons dengan error (misal, "Session is already full")
          return BookingResultClass(
              isSuccess: false, message: response.data['message']);
        }
      } else {
        // Jika response data null
        return BookingResultClass(
            isSuccess: false, message: "Failed to book session");
      }
    } else {
      // Jika status code bukan 200
      return BookingResultClass(
          isSuccess: false, message: "Failed to book session");
    }
  } on DioError catch (e) {
    // Jika terjadi DioError
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
