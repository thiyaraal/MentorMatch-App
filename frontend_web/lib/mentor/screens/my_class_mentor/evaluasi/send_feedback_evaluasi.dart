import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/detail_class_mentor_all_screen.dart';
import 'package:my_flutter_app/mentor/Screens/my_class_mentor/evaluasi/list_evaluasi_mentor_screen.dart';
import 'package:my_flutter_app/mentor/model/my_class_mentor_model.dart';
import 'package:my_flutter_app/mentor/service/myClassCreate_Mentor_service.dart';
import 'package:my_flutter_app/mentor/service/send_feedback_evaluation.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/flushsBar_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class DetailEvaluasiMenteeMentorScreen extends StatefulWidget {
  final String menteeName;
  final String currentMenteeId;
  final String classId;

  DetailEvaluasiMenteeMentorScreen({
    Key? key,
    required this.menteeName,
    required this.currentMenteeId,
    required this.classId,
  }) : super(key: key);

  @override
  State<DetailEvaluasiMenteeMentorScreen> createState() =>
      _DetailEvaluasiMenteeMentorScreenState();
}

class _DetailEvaluasiMenteeMentorScreenState
    extends State<DetailEvaluasiMenteeMentorScreen> {
  List<String> listMateriEvaluasi = [];
  String? selectedMateriFeedback;
  String? selectedEvaluationId;

  final TextEditingController _materiEvaluasiController2 =
      TextEditingController();
  final TextEditingController _hasilEvaluasiController =
      TextEditingController();
  final TextEditingController _nilaiEvaluasiController =
      TextEditingController();

  bool _isLoading = false;
  late Future<MyClassMentorMondel> _futureClassData;

  @override
  void initState() {
    super.initState();
    _futureClassData = ListClassMentor().fetchClassData();
  }

  @override
  void dispose() {
    _materiEvaluasiController2.dispose();
    _hasilEvaluasiController.dispose();
    _nilaiEvaluasiController.dispose();
    super.dispose();
  }

  void _sendFeedback() async {
    setState(() {
      _isLoading = true;
    });

    if (selectedMateriFeedback == null ||
        selectedEvaluationId == null ||
        _hasilEvaluasiController.text.isEmpty ||
        _nilaiEvaluasiController.text.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      // Display error message if any field is empty
      showTopSnackBar(context, "Field tidak boleh kosong",
          leftBarIndicatorColor: ColorStyle().errorColors);
      return;
    }

    try {
      final errorMessage = await FeedbackService.sendFeedback(
        selectedEvaluationId!,
        widget.currentMenteeId,
        _hasilEvaluasiController.text,
        int.parse(_nilaiEvaluasiController.text),
      );

      setState(() {
        _isLoading = false;
      });

      if (errorMessage == null) {
        showTopSnackBar(context, 'Feedback berhasil dikirim.',
            leftBarIndicatorColor: ColorStyle().succesColors);

        // Clear the form after successful submission
        _hasilEvaluasiController.clear();
        _nilaiEvaluasiController.clear();
        setState(() {
          selectedMateriFeedback = null;
          selectedEvaluationId = null;
        });
      } else {
        showTopSnackBar(context, errorMessage,
            leftBarIndicatorColor: ColorStyle().errorColors);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showTopSnackBar(context, 'Terjadi kesalahan',
          leftBarIndicatorColor: ColorStyle().errorColors);
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
            "Send Feedback Evaluasi",
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
            return Container(
                height: MediaQuery.of(context).size.height / 2.0,
                child: Center(child: CircularProgressIndicator()));
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(
                        title: "Nama Mentee",
                        color: ColorStyle().secondaryColors,
                      ),
                      Text(widget.menteeName, style: FontFamily().regularText),
                      const SizedBox(
                        height: 12,
                      ),
                      TittleTextField(
                        title: "Jumlah Evaluasi yang di terima",
                        color: ColorStyle().secondaryColors,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${classData.evaluations?.length ?? 0} Evaluasi",
                              style: FontFamily().regularText),
                          const SizedBox(
                            width: 12,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListEvaluasiMentee(
                                    nameMentee: widget.menteeName,
                                    classId: widget.classId,
                                    currentMenteeId: widget.currentMenteeId,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Lihat Semua',
                              style: FontFamily()
                                  .buttonText
                                  .copyWith(color: ColorStyle().primaryColors),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 12),
                                    child: Text(
                                      "Berikan Hasil Evaluasi Mentee",
                                      style: FontFamily().boldText.copyWith(
                                          color: ColorStyle().primaryColors,
                                          fontSize: 16),
                                    ),
                                  ),
                                  TittleTextField(
                                    title: "Materi Evaluasi",
                                    color: ColorStyle().secondaryColors,
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: selectedMateriFeedback,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: ColorStyle().tertiaryColors,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Pilih materi evaluasi',
                                      hintStyle: FontFamily()
                                          .regularText
                                          .copyWith(
                                            color: ColorStyle().disableColors,
                                          ),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedMateriFeedback = newValue;
                                        // Find the evaluation that matches the selected topic to get its ID
                                        final selectedEvaluation =
                                            classData.evaluations?.firstWhere(
                                          (evaluation) =>
                                              evaluation.topic == newValue,
                                          orElse: () => Evaluation(),
                                        );
                                        // Only set selectedEvaluationId if a valid evaluation is found
                                        selectedEvaluationId =
                                            selectedEvaluation?.id != null
                                                ? selectedEvaluation?.id
                                                : null;
                                      });
                                    },
                                    items: classData.evaluations
                                            ?.map<DropdownMenuItem<String>>(
                                          (Evaluation evaluation) {
                                            return DropdownMenuItem<String>(
                                              value: evaluation.topic,
                                              child: Text(
                                                evaluation.topic ?? "",
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList() ??
                                        [],
                                    isExpanded: true,
                                  ),
                                  const SizedBox(height: 12),
                                  TittleTextField(
                                    title: "Hasil Evaluasi",
                                    color: ColorStyle().secondaryColors,
                                  ),
                                  TextFormField(
                                    controller: _hasilEvaluasiController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText:
                                            "Masukan hasil dari evaluasi yang di kerjakan oleh mentee",
                                        hintStyle: FontFamily()
                                            .regularText
                                            .copyWith(
                                                color: ColorStyle()
                                                    .disableColors)),
                                    maxLines: 5,
                                  ),
                                  const SizedBox(height: 12),
                                  TittleTextField(
                                    title: "Nilai Evaluasi",
                                    color: ColorStyle().secondaryColors,
                                  ),
                                  TextFormField(
                                    controller: _nilaiEvaluasiController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText:
                                            "Masukan nilai dari evaluasi yang di kerjakan oleh mentee",
                                        hintStyle: FontFamily()
                                            .regularText
                                            .copyWith(
                                                color: ColorStyle()
                                                    .disableColors)),
                                  ),
                                  const SizedBox(height: 12),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: _isLoading
                                        ? CircularProgressIndicator() // Show loading indicator
                                        : SmallElevatedButtonTag(
                                            onPressed: () {
                                              _sendFeedback();
                                            },
                                            height: 40,
                                            width: 118,
                                            title: "Kirim",
                                            style: FontFamily()
                                                .buttonText
                                                .copyWith(
                                                  fontSize: 12,
                                                  color:
                                                      ColorStyle().whiteColors,
                                                ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
