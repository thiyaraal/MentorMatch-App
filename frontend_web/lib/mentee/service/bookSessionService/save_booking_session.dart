import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Untuk menggunakan json.encode dan json.decode

Future<void> saveBookingData(
    String namaSession, String namaMentor, String jadwalSession) async {
  final prefs = await SharedPreferences.getInstance();
  // Ambil data pemesanan yang sudah ada
  final existingData = prefs.getString('bookingHistory') ?? '[]';
  List<dynamic> history = json.decode(existingData);
  // Tambahkan data pemesanan baru
  history.add({
    'nama_session': namaSession,
    'nama_mentor': namaMentor,
    'jadwal_session': jadwalSession,
    'tanggal_booking':
        DateTime.now().toString(), // Menambahkan timestamp booking
  });
  // Simpan kembali ke shared preferences
  await prefs.setString('bookingHistory', json.encode(history));
}
