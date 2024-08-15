import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/provider/review_mentor_provider.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:provider/provider.dart';

class ReviewMentorScreen extends StatefulWidget {
  final String mentorId;
  final String mentorPhoto;
  final String mentorName;
  final String className;
  final int classPeriode;
  ReviewMentorScreen(
      {Key? key,
      required this.mentorName,
      required this.className,
      required this.classPeriode,
      required this.mentorPhoto,
      required this.mentorId})
      : super(key: key);

  @override
  State<ReviewMentorScreen> createState() => _ReviewMentorScreenState();
}

class _ReviewMentorScreenState extends State<ReviewMentorScreen> {
  final TextEditingController _reviewController = TextEditingController();
  bool _isSendingReview = false;

  @override
  void dispose() {
    // Membersihkan controller ketika state object dihancurkan
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Mentor'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorStyle().tertiaryColors, // Warna border
                    width: 1, // Lebar border
                  ),
                  color: Colors
                      .transparent, // Warna bagian dalam, bisa diatur menjadi transparent atau null
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: widget.mentorPhoto,
                              fit: BoxFit.cover,
                              width: 98,
                              height: 98,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.mentorName ?? '',
                                  style: FontFamily().boldText.copyWith(
                                      fontSize: 14,
                                      color: ColorStyle().primaryColors),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Mentor : ${widget.mentorName}',
                                  style: FontFamily().regularText,
                                ),
                                Text(
                                  'Durasi : ${widget.classPeriode} Hari',
                                  style: FontFamily().regularText,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _reviewController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Tulis Review",
                  hintStyle: FontFamily().regularText,
                ),
                maxLines: 5,
              ),
              Text(
                "Gunakan kata yang baik dan sopan, nama dan identitas kamu akan tersimpan dalam profile mentor",
                style: FontFamily().regularText,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallOutlinedButton(
                    width: 150,
                    height: 38,
                    title: "Batal",
                    style: FontFamily().buttonText.copyWith(
                          fontSize: 12,
                          color: ColorStyle().primaryColors,
                        ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    child: _isSendingReview
                        ? const CircularProgressIndicator()
                        : SmallElevatedButton(
                            width: 150,
                            height: 38,
                            title: "Kirim",
                            style: FontFamily().buttonText.copyWith(
                                  fontSize: 12,
                                  color: ColorStyle().whiteColors,
                                ),
                            onPressed: () async {
                              setState(() {
                                _isSendingReview = true;
                              });
                              // Pastikan untuk mendapatkan userId dengan cara yang benar
                              final userId = await UserPreferences
                                  .getUserId(); // Pastikan ini asynchronous call
                              if (userId == null) {
                                // Handle user belum login
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Anda harus login terlebih dahulu.')),
                                );
                                return;
                              }

                              String message = await reviewProvider.sendReview(
                                  _reviewController.text,
                                  userId,
                                  widget.mentorId,
                                  context);
                              setState(() {
                                _isSendingReview = false;
                              });

                              // Menunggu Flushbar ditampilkan selama beberapa detik sebelum navigasi
                              // ignore: prefer_const_constructors
                              await Future.delayed(Duration(
                                  seconds:
                                      3)); // Sesuaikan durasi dengan durasi Flushbar
                              setState(() {
                                _isSendingReview = false;
                              });
                              // Navigasi ke halaman baru
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavbarMenteeScreen()),
                                (Route<dynamic> route) => false,
                              );
                            },
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // buat dengan showTopSnackBar apabila review berhaisl dikirim
}
