import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/detail_class_mentor_all_screen.dart';
import 'package:my_flutter_app/mentor/model/my_class_mentor_model.dart';
import 'package:my_flutter_app/mentor/screens/my_class_mentor/evaluasi/send_feedback_evaluasi.dart';
import 'package:my_flutter_app/mentor/service/myClassCreate_Mentor_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/flushsBar_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../service/sent_evaluasi_service.dart';

class EvaluasiMentorScreen extends StatefulWidget {
  final List<FeedbackMyClassMentor> feedbacks;
  final String classId;
  final List<Transaction> transactions;
  final List<Evaluation> evaluasi;
  // final List<LearningMaterialMentor> learningMaterial;

  const EvaluasiMentorScreen({
    super.key,
    required this.feedbacks,
    required this.classId,
    // required this.learningMaterial,
    required this.evaluasi,
    required this.transactions,
  });

  @override
  State<EvaluasiMentorScreen> createState() => _EvaluasiMentorScreenState();
}

class _EvaluasiMentorScreenState extends State<EvaluasiMentorScreen> {
  String? selectedEvaluationId;
  String? selectedMateriEvaluasi;
  List<String> learningMaterial = [];
  late Future<MyClassMentorMondel> _futureClassData;

  bool _isLoading = false;
  final TextEditingController _materiEvaluasiController =
      TextEditingController();
  final TextEditingController _linkEvaluasiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureClassData = ListClassMentor().fetchClassData();
  }

  @override
  void dispose() {
    _materiEvaluasiController.dispose();
    _linkEvaluasiController.dispose();

    super.dispose();
  }

  Future<void> _sendEvaluation() async {
    await Future.delayed(Duration(seconds: 1));
    String title = _materiEvaluasiController.text;
    String link = _linkEvaluasiController.text;
    if (title.isEmpty || link.isEmpty) {
      // Tampilkan pesan error jika salah satu field kosong
      showTopSnackBar(context, "Field tidak boleh kosong",
          leftBarIndicatorColor: ColorStyle().errorColors);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final service = SendEvaluasiService();
      String responseMessage = await service.sendEvaluationLink(
        widget.classId,
        _materiEvaluasiController.text,
        _linkEvaluasiController.text,
      );

      if (responseMessage.contains("berhasil")) {
        // Tampilkan snackbar dengan warna hijau untuk pesan sukses dari server
        showTopSnackBar(context, responseMessage,
            leftBarIndicatorColor: ColorStyle().succesColors);
        // Bersihkan form setelah berhasil

        _linkEvaluasiController.clear(); // Mengosongkan nilai controller
        setState(() {
          selectedMateriEvaluasi = null;
          widget.evaluasi.add(
            Evaluation(topic: title, link: link),
          );
        });
      } else {
        // Tampilkan snackbar dengan warna merah untuk pesan error dari server
        showTopSnackBar(context, responseMessage,
            leftBarIndicatorColor: ColorStyle().errorColors);
      }
    } catch (e) {
      // Tangkap error yang terjadi pada sisi Flutter
      showTopSnackBar(context, "Terjadi kesalahan saat mengirim evaluasi",
          leftBarIndicatorColor: ColorStyle().errorColors);
    } finally {
      setState(() => _isLoading = false);

      setState(() {
        _futureClassData = ListClassMentor().fetchClassData();
      });
    }
  }

  _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Evaluasi Mentee",
            style: FontFamily()
                .titleText
                .copyWith(color: ColorStyle().primaryColors),
          ),
        ],
      )),
      body: FutureBuilder<MyClassMentorMondel>(
        future: _futureClassData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData &&
              snapshot.data!.user?.userClass != null) {
            var userClass = snapshot.data!.user!.userClass!;

            final classData = userClass.firstWhere(
              (userClass) => userClass.id == widget.classId,
              orElse: () => AllClass(),
            );
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Panduan Evaluasi",
                        style: FontFamily().boldText.copyWith(
                            color: ColorStyle().primaryColors, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorStyle().tertiaryColors,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '1. ',
                                      style: FontFamily().regularText,
                                    ),
                                    TextSpan(
                                      style: FontFamily().regularText,
                                      text:
                                          'Evaluasi  dilakukan setiap satu topik dalam program dan layanan sebagai penilaian atau pemeriksaan sistematis untuk mengevaluasi efektivitas, efisiensi, dan dampak dari suatu topik yang telah di ajarkan dalam program atau layanan. \n',
                                    ),
                                    TextSpan(
                                      text: '2. ',
                                      style: FontFamily().regularText,
                                    ),
                                    TextSpan(
                                      style: FontFamily().regularText,
                                      text:
                                          'Tujuan evaluasi ini adalah untuk mengukur sejauh mana mentee dalam pencapain pembelajaran, mengidentifikasi area perbaikan, dan memberikan umpan balik yang dapat digunakan untuk meningkatkan kualitas dan efisiensi pelaksanaan program atau layanan tersebut.\n',
                                    ),
                                    TextSpan(
                                      text: '3. ',
                                      style: FontFamily().regularText,
                                    ),
                                    TextSpan(
                                      style: FontFamily().regularText,
                                      text:
                                          'Evaluasi akan di berikan oleh mentor yang membimbingan kelas dalam bentu form yang akan di kirim pada saat kegiatan menting berlangsung ( zoom meeting)\n',
                                    ),
                                    TextSpan(
                                      text: '4. ',
                                      style: FontFamily().regularText,
                                    ),
                                    TextSpan(
                                      style: FontFamily().regularText,
                                      text:
                                          'Hasil dari evaluasi akan dikirim mentor pada halaman ini apabila mentee telah mengejakan dan mentor telah menilai dari jawaban yang mentee berikan.\n',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                          border: Border.all(
                              color: ColorStyle().tertiaryColors, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                child: Text(
                                  "Kirim Evaluasi Mentee",
                                  style: FontFamily().boldText.copyWith(
                                      color: ColorStyle().primaryColors,
                                      fontSize: 16),
                                ),
                              ),
                              TittleTextField(
                                title: "Materi Evaluasi",
                                color: ColorStyle().secondaryColors,
                              ),
                              // TextFieldWidget(
                              //   controller: _materiEvaluasiController,
                              //   hintText: "nama topik materi evaluasi",
                              // ),
                              DropdownButtonFormField<String>(
                                value: selectedMateriEvaluasi,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorStyle().tertiaryColors,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Pilih materi evaluasi',
                                  hintStyle: FontFamily().regularText.copyWith(
                                        color: ColorStyle().disableColors,
                                      ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedMateriEvaluasi = newValue;
                                    // Cari materi evaluasi yang sesuai dari list
                                    final selectedMaterial =
                                        classData.learningMaterial!.firstWhere(
                                      (material) => material.title == newValue,
                                      orElse: () => LearningMaterialMentor(
                                          title: "", link: ""),
                                    );
                                    // Perbarui controller dengan title dari materi yang dipilih
                                    _materiEvaluasiController.text =
                                        selectedMaterial.title ?? "";
                                  });
                                },
                                items: classData.learningMaterial!
                                    .map((LearningMaterialMentor material) {
                                  return DropdownMenuItem<String>(
                                    value: material.title,
                                    child: Text(material.title ?? ""),
                                  );
                                }).toList(),
                                isExpanded: true,
                              ),

                              TittleTextField(
                                title: "Link Evaluasi",
                                color: ColorStyle().secondaryColors,
                              ),
                              TextFieldWidget(
                                controller: _linkEvaluasiController,
                                hintText: "masukkan link evaluasi",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Field tidak boleh kosong';
                                  }

                                  const urlPattern =
                                      r'^(https?:\/\/)?([a-z0-9-]+\.)+[a-z]{2,6}(\/[^\s]*)?$';
                                  final urlRegExp = RegExp(urlPattern);

                                  if (!urlRegExp.hasMatch(value)) {
                                    return 'Please enter a valid URL';
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: _isLoading
                                    ? CircularProgressIndicator() // Tampilkan indikator loading jika sedang loading
                                    : SmallElevatedButtonTag(
                                        onPressed: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          await _sendEvaluation();
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        },
                                        height: 40,
                                        width: 118,
                                        title: "Kirim",
                                        style: FontFamily().buttonText.copyWith(
                                              fontSize: 12,
                                              color: ColorStyle().whiteColors,
                                            ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "List Mentee di Kelas Anda",
                        style: FontFamily().boldText.copyWith(
                            color: ColorStyle().primaryColors, fontSize: 16),
                      ),
                      Column(
                        children: widget.transactions
                                .where((transaction) =>
                                    transaction.paymentStatus == 'Approved')
                                .isEmpty
                            ? [
                                Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Center(
                                    child: Text("Belum ada mentee",
                                        style: FontFamily().regularText),
                                  ),
                                )
                              ]
                            : List.generate(
                                widget.transactions
                                    .where((transaction) =>
                                        transaction.paymentStatus == 'Approved')
                                    .length,
                                (index) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevetadButtonWithIcon(
                                        title: widget
                                            .transactions[index].user!.name!,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailEvaluasiMenteeMentorScreen(
                                                classId: widget
                                                    .transactions[index].classId
                                                    .toString(),
                                                currentMenteeId: widget
                                                    .transactions[index].userId
                                                    .toString(),
                                                menteeName: widget
                                                    .transactions[index]
                                                    .user!
                                                    .name
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Data tidak ditemukan"),
            );
          }
        },
      ),
    );
  }
}
