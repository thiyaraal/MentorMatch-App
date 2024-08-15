import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/service/review_mentor_service.dart';
import 'package:my_flutter_app/widget/menucategory.dart';


class ReviewProvider with ChangeNotifier {
  bool _isLoading = false;
  final ReviewService _reviewService = ReviewService();

  bool get isLoading => _isLoading;

  Future<String> sendReview(String reviewText, String userId, String mentorId,
      BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    String message;

    try {
      // Gunakan _reviewService untuk mengirim review ke server dan menangkap pesan sukses
      await _reviewService.sendReview(reviewText, userId, mentorId);
      message = "Review berhasil dikirim.";
    } catch (e) {
      // Handle jika terjadi error dan menangkap pesan error
      message =
          e.toString(); // Asumsikan bahwa exception mengembalikan pesan error
    }

    _isLoading = false;
    notifyListeners();

    // Menampilkan snackbar dengan pesan sukses/error
    showTopSnackBar(context, message);

    return message; // Mengembalikan pesan untuk keperluan lain jika diperlukan
  }

  void showTopSnackBar(BuildContext context, String message) {
    Flushbar(
      backgroundColor: ColorStyle().secondaryColors,
      message: message,
      icon: Icon(
        Icons.check_circle_outline,
        size: 28.0,
        color: ColorStyle().whiteColors,
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: ColorStyle().succesColors,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP, // Menampilkan di bagian atas
    ).show(context);
  }
}
