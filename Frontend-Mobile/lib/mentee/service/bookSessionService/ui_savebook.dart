import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingHistoryScreen extends StatefulWidget {
  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  Future<List<dynamic>> fetchBookingHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String bookingData = prefs.getString('bookingHistory') ?? '[]';
    return json.decode(bookingData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Pemesanan"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchBookingHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text(item['nama_session']),
                  subtitle: Text(
                      "Mentor: ${item['nama_mentor']}\nTanggal: ${item['jadwal_session']}"),
                );
              },
            );
          } else {
            return Text("Tidak ada data");
          }
        },
      ),
    );
  }
}
