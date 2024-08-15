// import 'package:dio/dio.dart';
// import 'package:mentormatch_apps/style/baseURl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
//   Dio dio = Dio();


//   Future<void> loginUser(String idToken) async {
//     try {
//       final response = await dio.post(
//         '$baseUrl/login',
//         data: {
//           'token':
//               idToken, // Pastikan ini sesuai dengan cara server Anda menerima token
//         },
//       );

//       if (response.statusCode == 200) {
//         print("Login berhasil: ${response.data}");

//         // Simpan user ID dan token ke SharedPreferences
//         final userId = response.data['user']['id'];
//         final token = response.data['token'];
//         final name = response.data['user']['name'];
//         final email = response.data['user']['email'];
//         final photoUrl = response.data['user']['photoUrl'];
//         final userType = response.data['user']['userType'];

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('userId', userId);
//         await prefs.setString('token', token);
//         await prefs.setString('name', name);
//         await prefs.setString('email', email);
//         await prefs.setString('photoUrl', photoUrl);
//         await prefs.setString('userType', userType);
//       } else {
//         print("Error saat login: ${response.statusCode}");
//       }
//     } on DioError catch (e) {
//       print("Dio error: ${e.response?.data ?? e.message}");
//     } catch (e) {
//       print("Error umum: $e");
//     }
//   }

//   // Function ini digunakan untuk mengambil data user ID dan token dari SharedPreferences

//   static Future<Map<String, String?>> getUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userId = prefs.getString('userId');
//     final token = prefs.getString('token');
//     final name = prefs.getString('name');
//     final email = prefs.getString('email');
//     final photoUrl = prefs.getString('photoUrl');
//     final userType = prefs.getString('userType');

//     return {
//       'userId': userId,
//       'token': token,
//       'name': name,
//       'email': email,
//       'photoUrl': photoUrl,
//       'userType': userType,
//     };
//   }
// }
