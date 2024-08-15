import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/provider/review_mentor_provider.dart';
import 'package:my_flutter_app/mentee/screen/homepage_mentee.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/detail_class_mentor_all_screen.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
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
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/blank_profile.jpg',
                                fit: BoxFit.cover,
                              ),
                              imageUrl: widget.mentorPhoto.toString(),
                              fit: BoxFit.cover,
                              width: 140,
                              height: 140,
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
                                  'Nama Kelas : ${widget.className}',
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
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: TextFormField(
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
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                " * Gunakan kata yang baik dan sopan, nama dan identitas kamu akan tersimpan dalam profile mentor",
                style: FontFamily().regularText,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                  const SizedBox(
                    width: 40,
                  ),
                  SizedBox(
                    child: _isSendingReview
                        ? const CircularProgressIndicator()
                        : SmallElevatedButtonTag(
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
                                    builder: (context) => MenteeHomePage()),
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
