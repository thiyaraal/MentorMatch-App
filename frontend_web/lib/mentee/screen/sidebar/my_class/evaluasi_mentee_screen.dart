import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/model/my_class_model.dart';
import 'package:my_flutter_app/mentee/screen/notification_mentee_screen.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

class EvaluasiMenteeScreen extends StatefulWidget {
  final List<EvaluationMyClass> evaluasi;

  EvaluasiMenteeScreen({Key? key, required this.evaluasi}) : super(key: key);

  @override
  State<EvaluasiMenteeScreen> createState() => _EvaluasiMenteeScreenState();
}

class _EvaluasiMenteeScreenState extends State<EvaluasiMenteeScreen> {
  String?
      currentMenteeId; // Variable to store currentMenteeId, initialized as null

  @override
  void initState() {
    super.initState();
    getCurrentMenteeId(); // Call method to get currentMenteeId
  }

  void getCurrentMenteeId() async {
    await UserPreferences.init();
    String? id = UserPreferences.getUserId(); // Get userId from UserPreferences
    setState(() {
      currentMenteeId = id;
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentMenteeId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Evaluasi",
            style: FontFamily().titleText.copyWith(
                  color: ColorStyle().primaryColors,
                ),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Filter evaluations based on currentMenteeId in feedbacks
    final menteeEvaluations = widget.evaluasi.where((evaluation) {
      // Include all evaluations
      return true;
    }).toList();

    // Sort the filtered evaluations based on whether they have feedback
    menteeEvaluations.sort((a, b) {
      bool hasFeedbackA = a.feedbacks != null &&
          a.feedbacks!.any((feedback) => feedback.menteeId == currentMenteeId);
      bool hasFeedbackB = b.feedbacks != null &&
          b.feedbacks!.any((feedback) => feedback.menteeId == currentMenteeId);
      return hasFeedbackA == hasFeedbackB
          ? 0
          : hasFeedbackA
              ? -1
              : 1;
    });
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Evaluasi",
              style: FontFamily().titleText.copyWith(
                    color: ColorStyle().primaryColors,
                  ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationMenteeScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.notifications_none_outlined,
                color: ColorStyle().secondaryColors,
              ),
            ),
          ],
        ),
      ),
      body: menteeEvaluations.isEmpty
          ? Center(
              child: Image.asset(
                'assets/Handoff/ilustrator/empty_evaluation.png',
                height: 300,
              ),
            )
          : ListView.builder(
              itemCount: menteeEvaluations.length,
              itemBuilder: (context, index) {
                var evaluation = menteeEvaluations[index];

                // Filter feedbacks to only include those from the current mentee
                final currentMenteeFeedbacks = evaluation.feedbacks!
                    .where((feedback) => feedback.menteeId == currentMenteeId)
                    .toList();

                return Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(
                        color: ColorStyle().tertiaryColors,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/Handoff/icon/MyClass/evaluasi_icon.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          evaluation.topic ?? 'Tidak ada topik',
                                          style: FontFamily().boldText.copyWith(
                                                fontSize: 16,
                                                color: ColorStyle()
                                                    .secondaryColors,
                                              ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              currentMenteeFeedbacks != null &&
                                                      currentMenteeFeedbacks
                                                          .isNotEmpty
                                                  ? currentMenteeFeedbacks
                                                      .map((feedback) => Text(
                                                            "result : ${feedback.result}",
                                                            style: FontFamily()
                                                                .boldText
                                                                .copyWith(
                                                                  fontSize: 16,
                                                                  color: ColorStyle()
                                                                      .secondaryColors,
                                                                ),
                                                          ))
                                                      .toList()
                                                  : [
                                                      Text(
                                                        "Nilai :-",
                                                        style: FontFamily()
                                                            .boldText
                                                            .copyWith(
                                                              fontSize: 16,
                                                              color: ColorStyle()
                                                                  .secondaryColors,
                                                            ),
                                                      ),
                                                    ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  ...(currentMenteeFeedbacks.isNotEmpty
                                      ? [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: currentMenteeFeedbacks
                                                  .map(
                                                    (feedback) => Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Feedback :",
                                                          style: FontFamily()
                                                              .boldText
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  color: ColorStyle()
                                                                      .secondaryColors),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Text(
                                                          'Feedback evaluasi: \n${feedback.content}',
                                                          style: FontFamily()
                                                              .regularText,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  .toList(),
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
                                                Text(
                                                  "Feedback :",
                                                  style: FontFamily()
                                                      .boldText
                                                      .copyWith(
                                                        fontSize: 16,
                                                        color: ColorStyle()
                                                            .secondaryColors,
                                                      ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Belum ada feedback',
                                                  style:
                                                      FontFamily().regularText,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: currentMenteeFeedbacks.isNotEmpty
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
                                    onPressed: null, // Dinonaktifkan
                                    child: Text(
                                      'Selesai',
                                      style: FontFamily().buttonText.copyWith(
                                            fontSize: 12,
                                            color: ColorStyle().whiteColors,
                                          ),
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
                                      style: FontFamily().buttonText.copyWith(
                                            fontSize: 12,
                                            color: ColorStyle().whiteColors,
                                          ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
