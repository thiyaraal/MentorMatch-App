import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart'; // Asumsikan ini adalah path yang benar

void showTopSnackBar(BuildContext context, String message,
    {Color leftBarIndicatorColor = Colors.blue}) {
  Flushbar(
    backgroundColor: ColorStyle().secondaryColors,
    message: message,
    icon: const Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.white, // Atur warna ikon menjadi putih
    ),
    duration: const Duration(seconds: 3),
    leftBarIndicatorColor: leftBarIndicatorColor,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    flushbarPosition: FlushbarPosition.TOP, // Menampilkan di bagian atas
  ).show(context);
}
