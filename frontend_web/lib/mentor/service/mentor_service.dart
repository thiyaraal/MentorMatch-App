// import 'package:dio/dio.dart';
// import 'package:mentormatch_apps/mentor/model/mentor_model.dart';
// import 'package:mentormatch_apps/style/baseURl.dart'; // Pastikan path ini sesuai

// class MentorService {
//   final Dio _dio = Dio();

//   // URL yang sudah disesuaikan dengan endpoint baru

//   Future<MentorClassModel> fetchFilteredMentors() async {
//     try {
//       // Melakukan request GET ke endpoint filter-mentors
//       final response = await _dio.get('$baseUrl/class/filter-mentors');
//       // Menggunakan MentorClassModel untuk parsing data JSON yang diterima
//       return MentorClassModel.fromMap(response.data);
//     } catch (error) {
//       // Menangani kesalahan yang mungkin terjadi selama request atau parsing
//       throw Exception("Failed to fetch filtered mentors: $error");
//     }
//   }
// }
