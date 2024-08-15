import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/my_class_mentor_model.dart';
import 'package:mentormatch_apps/mentor/service/my_class_create_mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:url_launcher/url_launcher.dart';

class ListEvaluasiMentee extends StatefulWidget {
  final String nameMentee;
  final String currentMenteeId;
  final String classId;

  const ListEvaluasiMentee({
    super.key,
    required this.nameMentee,
    required this.classId,
    required this.currentMenteeId,
  });

  @override
  State<ListEvaluasiMentee> createState() => _ListEvaluasiMenteeState();
}

class _ListEvaluasiMenteeState extends State<ListEvaluasiMentee> {
  late Future<MyClassMentorMondel> classData;

  @override
  void initState() {
    super.initState();
    classData = ListClassMentor().fetchClassData();
  }

  Future<void> _launchURL(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Tidak dapat membuka $urlString';
      }
    } catch (e) {
      throw 'URL tidak valid: $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nameMentee,
          style: FontFamily()
              .boldText
              .copyWith(fontSize: 16, color: ColorStyle().primaryColors),
        ),
      ),
      body: FutureBuilder<MyClassMentorMondel>(
        future: classData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: MediaQuery.of(context).size.height / 2.0,
                child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData &&
              snapshot.data!.user?.userClass != null) {
            var userClass = snapshot.data!.user!.userClass!
                .where((userClass) => userClass.id == widget.classId)
                .toList();

            var evaluations = userClass[0].evaluations ?? [];

            if (evaluations.isEmpty) {
              return Center(
                child: Image.asset(
                  'assets/Handoff/ilustrator/empty_evaluation.png',
                  height: 200,
                ),
              );
            }
            return ListView.builder(
              itemCount: userClass.length,
              itemBuilder: (context, index) {
                var evaluations = userClass[index].evaluations ?? [];

                // Filter evaluasi yang memiliki feedback untuk currentMenteeId
                var filteredEvaluations = evaluations.where((evaluation) {
                  var feedbacksForCurrentMentee = evaluation.feedbacks
                          ?.where((feedback) =>
                              feedback.menteeId == widget.currentMenteeId)
                          .toList() ??
                      [];
                  return feedbacksForCurrentMentee.isNotEmpty;
                }).toList();

                // Filter evaluasi yang tidak memiliki feedback untuk currentMenteeId
                var evaluationsWithoutFeedback =
                    evaluations.where((evaluation) {
                  var feedbacksForCurrentMentee = evaluation.feedbacks
                          ?.where((feedback) =>
                              feedback.menteeId == widget.currentMenteeId)
                          .toList() ??
                      [];
                  return feedbacksForCurrentMentee.isEmpty;
                }).toList();

                // Gabungkan kembali evaluasi dengan feedback di atas
                var sortedEvaluations = [
                  ...filteredEvaluations,
                  ...evaluationsWithoutFeedback
                ];

                return Column(
                  children: sortedEvaluations.map((evaluation) {
                    var feedbacksForCurrentMentee = evaluation.feedbacks
                            ?.where((feedback) =>
                                feedback.menteeId == widget.currentMenteeId)
                            .toList() ??
                        [];

                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, bottom: 24.0),
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 4.0,
                          left: 4.0,
                        ),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              color: ColorStyle().tertiaryColors, width: 2),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/Handoff/icon/MyClass/evaluasi_icon.png',
                                  width: 80,
                                  height: 80,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${evaluation.topic}",
                                              style: FontFamily()
                                                  .boldText
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: ColorStyle()
                                                          .secondaryColors),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: feedbacksForCurrentMentee
                                                      .isEmpty
                                                  ? [
                                                      Text("Nilai :-",
                                                          style: FontFamily()
                                                              .boldText
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  color: ColorStyle()
                                                                      .secondaryColors))
                                                    ]
                                                  : feedbacksForCurrentMentee
                                                      .map((feedback) {
                                                      return Text(
                                                        "result : ${feedback.result}",
                                                        style: FontFamily()
                                                            .boldText
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: ColorStyle()
                                                                    .secondaryColors),
                                                      );
                                                    }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      ...(feedbacksForCurrentMentee.isNotEmpty)
                                          ? [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children:
                                                      feedbacksForCurrentMentee
                                                          .map((feedback) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Feedback :",
                                                            style: FontFamily()
                                                                .boldText
                                                                .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                    color: ColorStyle()
                                                                        .secondaryColors)),
                                                        const SizedBox(
                                                            height: 8),
                                                        Text(
                                                            '${feedback.content}',
                                                            style: FontFamily()
                                                                .regularText),
                                                      ],
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ]
                                          : [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Feedback :",
                                                        style: FontFamily()
                                                            .boldText
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: ColorStyle()
                                                                    .secondaryColors)),
                                                    const SizedBox(height: 8),
                                                    Text('Belum ada feedback',
                                                        style: FontFamily()
                                                            .regularText),
                                                  ],
                                                ),
                                              ),
                                            ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: feedbacksForCurrentMentee.isNotEmpty
                                  ? SizedBox(
                                      height: 40,
                                      width: 160,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              ColorStyle().disableColors,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                        ),
                                        onPressed: null,
                                        child: Text(
                                          'Selesai',
                                          style: FontFamily()
                                              .buttonText
                                              .copyWith(
                                                  fontSize: 12,
                                                  color:
                                                      ColorStyle().whiteColors),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 40,
                                      width: 160,
                                      child: TextButton.icon(
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              ColorStyle().primaryColors,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                        ),
                                        onPressed: () =>
                                            _launchURL(evaluation.link ?? ''),
                                        icon: Icon(Icons.link,
                                            color: ColorStyle().whiteColors),
                                        label: Text(
                                          'Buka Evaluasi',
                                          style: FontFamily()
                                              .buttonText
                                              .copyWith(
                                                  fontSize: 12,
                                                  color:
                                                      ColorStyle().whiteColors),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            );
          } else {
            return Center(child: Text('Tidak ada data'));
          }
        },
      ),
    );
  }
}
