import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/mentor/Screens/my_class_mentor/detail_my_class_mentor_screen.dart';
import 'package:my_flutter_app/mentor/Screens/my_class_mentor/edit_class_rejected.dart';
import 'package:my_flutter_app/mentor/service/myClassCreate_Mentor_service.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/my_class_mentor_model.dart';

class SearchPageMentorweb extends StatefulWidget {
  @override
  _SearchPageMentorwebState createState() => _SearchPageMentorwebState();
}

class _SearchPageMentorwebState extends State<SearchPageMentorweb> {
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();
  bool isSearching = false;

  ///class///
  List<AllClass> _classes = [];
  List<AllClass> _filteredClasses = [];

  /// session///
  List<Session> _sessions = [];
  List<Session> _filteredSessions = [];

  ////////////////////////
  late Future<MyClassMentorMondel> classData;
  late Future<List<Session>> sessionData;

  int _getPriorityClass(AllClass userClass) {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime.parse(
        userClass.startDate.toString()); // Asumsi startDate tidak null
    DateTime endDate = DateTime.parse(
        userClass.endDate.toString()); // Asumsi endDate tidak null

    int getAvailableSlotCount(AllClass userClass) {
      int approvedCount = userClass.transactions
              ?.where((t) => t.paymentStatus == "Approved")
              .length ??
          0;
      int pendingCount = userClass.transactions
              ?.where((t) => t.paymentStatus == "Pending")
              .length ??
          0;
      int totalApprovedAndPendingCount = approvedCount + pendingCount;
      return totalApprovedAndPendingCount;
    }

    int totalApprovedAndPendingCount = getAvailableSlotCount(userClass);

    bool isVerified = userClass.isVerified!;
    bool isActive = userClass.isActive!;
    bool isAvailable = userClass.isAvailable!;
    int maxParticipants = userClass.maxParticipants!;
    Color buttonColor = ColorStyle().primaryColors;
    String buttonText = "Available";
    bool isRejected = userClass.rejectReason != null;

    // Tentukan warna tombol dan teks berdasarkan kondisi status kelas

    if (isAvailable && totalApprovedAndPendingCount < maxParticipants) {
      buttonColor = ColorStyle().secondaryColors;
      buttonText = "Available";
    } else if (!isAvailable && !isVerified && !isActive && isRejected) {
      // Kondisi untuk "Rejected"
      buttonColor = ColorStyle().errorColors; // Warna untuk status "Rejected"
      buttonText = "Rejected";
      //kondisi pending
    } else if (!isAvailable &&
        !isVerified &&
        !isActive &&
        now.isBefore(startDate)) {
      buttonColor = ColorStyle().pendingColors;
      buttonText = "Pending";
    } else if (totalApprovedAndPendingCount >= maxParticipants && !isActive) {
      buttonColor = ColorStyle().fullbookedColors;
      buttonText = "Full";
      // ketika startDate = now , dan now <+ endDate
    } else if (isActive) {
      buttonColor = ColorStyle().succesColors;
      buttonText = "Active";
    } else if (totalApprovedAndPendingCount > 0 && now.isAfter(endDate)) {
      buttonColor = ColorStyle().disableColors;
      buttonText = "Completed";
    } else if (totalApprovedAndPendingCount == 0 && now.isAfter(startDate)) {
      buttonColor = ColorStyle().blackColors;
      buttonText = "Expired";
    } else {
      // Penanganan default jika ada, untuk kasus yang tidak tertangani oleh kondisi di atas
      buttonColor = ColorStyle().primaryColors; // Asumsi warna default
      buttonText = "Unavailable"; // Teks default
    }
    // Kembalikan prioritas yang dihitung
    return _calculatePriorityclass(buttonText);
  }

  int _calculatePriorityclass(String buttonText) {
    // Lakukan perhitungan prioritas berdasarkan teks tombol
    switch (buttonText) {
      case "Rejected":
        return 1;
      case "Pending":
        return 2;
      case "Full":
        return 3;
      case "Active":
        return 4;
      case "Completed":
        return 5;
      case "Expired":
        return 6;
      case "Unavailable":
        return 7;
      default:
        return 8;
    }
  }

  ///session///
  late Future<List<Session>> _sessionsFuture;

  int _getPrioritySession(Session userSessions) {
    String buttonText = "Available";
    // buttonCollor scheduled ketika isActive bernilai true + belum

    if (userSessions.isActive == true) {
      buttonText = "Scheduled";
      // buttonCollor full ketika participant.length == maxParticipant + startTime nya belum mulai + isActive bernilai false
    }
    if (userSessions.participant!.length == userSessions.maxParticipants &&
        DateTime.now().isBefore(DateTime.parse(userSessions.startTime!)) &&
        DateTime.now().isBefore(DateTime.parse(userSessions.endTime!)) &&
        userSessions.isActive == true) {
      buttonText = "Full";
    }

    // buttonCollor active ketika isActive bernilai false + participant.length >= 1 + dan waktunya masih berlangsung
    if (userSessions.isActive == false &&
        userSessions.participant!.length >= 1 &&
        DateTime.now().isBefore(DateTime.parse(userSessions.endTime!))) {
      buttonText = "Active";
    }
    if (userSessions.isActive == false &&
        userSessions.participant!.length == 0 &&
        DateTime.now().isAfter(DateTime.parse(userSessions.startTime!))) {
      buttonText = "Expired";
    }

    // buttonCollor finished ketika isActive bernilai false + participant.length >= 1 + sudah lewat endTime
    else if (userSessions.isActive == false &&
        userSessions.participant!.length >= 1 &&
        DateTime.now().isAfter(DateTime.parse(userSessions.endTime!))) {
      buttonText = "Finished";
    }

    return _calculatePrioritySessions(buttonText);
  }

  // susunannya ad
  int _calculatePrioritySessions(String buttonText) {
    if (buttonText == "Active") {
      return 1;
    } else if (buttonText == "Scheduled") {
      return 2;
    } else if (buttonText == "Full") {
      return 3;
    } else if (buttonText == "Finished") {
      return 4;
    } else if (buttonText == "Expired") {
      return 5;
    } else {
      return 0;
    }
  }

  Widget createStatusButton(String title, Color color) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: FontFamily().boldText.copyWith(
              color: color,
              fontSize: 16,
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchClasses();
    _fetchSessions();

    ///
    super.initState();
    // Initialize the future without passing userId
    classData = ListClassMentor().fetchClassData();
    sessionData = ListClassMentor().fetchSessionsForCurrentUser();

    /// mebuat sort sesuai dengan prioritas status
    classData.then((value) {
      value.user?.userClass?.sort((a, b) {
        return _getPriorityClass(a).compareTo(_getPriorityClass(b));
      });
    });
    //session
    _sessionsFuture = ListClassMentor().fetchSessionsForCurrentUser();

    /// Membuat sort sesuai dengan prioritas status
    _sessionsFuture.then((value) {
      value.sort((a, b) {
        return _getPrioritySession(a).compareTo(_getPrioritySession(b));
      });
      setState(() {}); // Atur ulang state setelah sorting dilakukan
    });
  }

//// fetch class ///
  Future<void> _fetchClasses() async {
    try {
      final userId = UserPreferences.getUserId();
      final response = await _dio.get('$baseUrl/users/$userId/my-class');
      if (response.statusCode == 200) {
        final model = MyClassMentorMondel.fromMap(response.data);
        if (model.user != null && model.user!.userClass != null) {
          setState(() {
            _classes = model.user!.userClass!;
            _filteredClasses = _classes;
          });
        } else {
          throw Exception("Class data not found");
        }
      } else {
        throw Exception("Failed to load classes");
      }
    } catch (e) {
      print(e); // Handle error accordingly
    }
  }

  /// fetch session ///
  Future<void> _fetchSessions() async {
    try {
      final userId = UserPreferences.getUserId();
      final response = await _dio.get('$baseUrl/users/$userId/my-class');
      if (response.statusCode == 200) {
        final model = MyClassMentorMondel.fromMap(response.data);
        if (model.user != null && model.user!.session != null) {
          setState(() {
            _sessions = model.user!.session!;
            _filteredSessions = _sessions;
          });
        } else {
          throw Exception("Session data not found");
        }
      } else {
        throw Exception("Failed to load sessions");
      }
    } catch (e) {
      print(e); // Handle error accordingly
    }
  }

  void _filterClasses(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      _filteredClasses = _classes
          .where((cls) =>
              cls.name!.toLowerCase().contains(query.toLowerCase()) ||
              cls.description!.toLowerCase().contains(query.toLowerCase()) ||
              cls.name!.toLowerCase().contains(query.toLowerCase()) ||
              cls.transactions!.any((transaction) => transaction.user!.name!
                  .toLowerCase()
                  .contains(query.toLowerCase())))
          .toList();

      _filteredSessions = _sessions
          .where((session) =>
              session.title!.toLowerCase().contains(query.toLowerCase()) ||
              session.description!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              session.dateTime!.toLowerCase().contains(query.toLowerCase()) ||
              session.endTime!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  //launch url
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: FontFamily().regularText.copyWith(
                color: ColorStyle().primaryColors,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorStyle().tertiaryColors),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: false,
                    controller: _searchController,
                    onChanged: _filterClasses,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search by mentee name or class name',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
                child: isSearching
                    ? ListView(
                        children: [
                          if (_filteredClasses.isNotEmpty) ...[
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0,
                                      left: 8.0,
                                      right: 8.0,
                                      bottom: 8.0),
                                  child: Text(
                                    'Kelas Premium',
                                    style: FontFamily().boldText.copyWith(
                                          fontSize: 16,
                                          color: ColorStyle().primaryColors,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Divider(
                                      color: ColorStyle()
                                          .disableColors
                                          .withOpacity(0.5),
                                      thickness: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            ..._filteredClasses.asMap().entries.map((entry) {
                              return buildClassWidget(entry.value, entry.key);
                            }),
                          ],
                          if (_filteredSessions.isNotEmpty) ...[
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0,
                                      left: 8.0,
                                      right: 8.0,
                                      bottom: 8.0),
                                  child: Text(
                                    'Sessions',
                                    style: FontFamily().boldText.copyWith(
                                          fontSize: 16,
                                          color: ColorStyle().primaryColors,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Divider(
                                      color: ColorStyle()
                                          .disableColors
                                          .withOpacity(0.5),
                                      thickness: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ..._filteredSessions.map((participant) {
                              return buildSessionWidget(participant);
                            }),
                          ],
                        ],
                      )
                    : Container()),
          ],
        ),
      ),
    );
  }

  Widget buildClassWidget(AllClass cls, int index) {
    var approvedTransactions = _filteredClasses[index]
            .transactions
            ?.where((transaction) => transaction.paymentStatus == "Approved")
            .toList() ??
        [];
///// classs////

    int statusButtonClass = _getPriorityClass(_filteredClasses[index]);

    final cls = _filteredClasses[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (statusButtonClass == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditRejectedClass(
                      classData: cls,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailMyClassMentorScreen(
                      feedbacks: cls.feedbacks ?? [],
                      addressMentoring: cls.address ?? 'Meeting Zoom',
                      locationMentoring: cls.location ?? '',
                      approvedTransactionsCount: approvedTransactions.length,
                      transactions: cls.transactions ?? [],
                      evaluation: cls.evaluations ?? [],
                      learningMaterial: cls.learningMaterial ?? [],
                      userClass: cls,
                      aksesLinkZoom: cls.zoomLink ?? '',
                      deskripsiKelas: cls.description.toString(),
                      classid: cls.id.toString(),
                      durationInDays: cls.durationInDays ?? 0,
                      endDate: DateTime.parse(cls.endDate ?? ''),
                      startDate: DateTime.parse(cls.startDate ?? ''),
                      term: cls.terms ?? [],
                      maxParticipants: cls.maxParticipants ?? 0,
                      schedule: cls.schedule ?? '',
                      targetLearning: cls.targetLearning ?? [],
                      linkZoom: cls.zoomLink ?? '',
                      namaKelas: cls.name ?? '',
                    ),
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorStyle().tertiaryColors,
                  width: 2,
                ),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    if (statusButtonClass == 1)
                      createStatusButton("Rejected", ColorStyle().errorColors),
                    if (statusButtonClass == 2)
                      createStatusButton("Pending", ColorStyle().pendingColors),
                    if (statusButtonClass == 3)
                      createStatusButton("Full", ColorStyle().fullbookedColors),
                    if (statusButtonClass == 4)
                      createStatusButton("Active", ColorStyle().succesColors),
                    if (statusButtonClass == 5)
                      createStatusButton(
                          "Completed", ColorStyle().disableColors),
                    if (statusButtonClass == 6)
                      createStatusButton("Expired", ColorStyle().blackColors),
                    if (statusButtonClass == 7)
                      createStatusButton(
                          "Unavailable", ColorStyle().primaryColors),
                    if (statusButtonClass == 8)
                      createStatusButton(
                          "Available", ColorStyle().secondaryColors),
                    SizedBox(height: 12),
                    Text(
                        //nama kelas
                        cls.name ?? '',
                        style: FontFamily().titleText.copyWith(
                              color: ColorStyle().secondaryColors,
                            )),
                    SizedBox(height: 12),
                    Text(
                      'Jumlah mentee terdaftar : ${approvedTransactions.length}',
                      style: FontFamily().regularText,
                    ),

                    const SizedBox(height: 12),
                    Text(
                      //durationIndays
                      'Durasi kelas : ${cls.durationInDays} hari',
                      style: FontFamily().regularText,
                    ),
                    // buat align text button di kanan menuju DetailMyclass namun aoabila statusnya rejected maka ke editrejectedClaas
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {
                    //       if (statusButtonClass == 1) {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => EditRejectedClass(
                    //               classData: cls,
                    //             ),
                    //           ),
                    //         );
                    //       } else {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => DetailMyClassMentorScreen(
                    //               feedbacks: cls.feedbacks ?? [],
                    //               addressMentoring: cls.address ?? 'Meeting Zoom',
                    //               locationMentoring: cls.location ?? '',
                    //               approvedTransactionsCount:
                    //                   approvedTransactions.length,
                    //               transactions: cls.transactions ?? [],
                    //               evaluation: cls.evaluations ?? [],
                    //               learningMaterial: cls.learningMaterial ?? [],
                    //               userClass: cls,
                    //               aksesLinkZoom: cls.zoomLink ?? '',
                    //               deskripsiKelas: cls.description.toString(),
                    //               classid: cls.id.toString(),
                    //               durationInDays: cls.durationInDays ?? 0,
                    //               endDate: DateTime.parse(cls.endDate ?? ''),
                    //               startDate: DateTime.parse(cls.startDate ?? ''),
                    //               term: cls.terms ?? [],
                    //               maxParticipants: cls.maxParticipants ?? 0,
                    //               schedule: cls.schedule ?? '',
                    //               targetLearning: cls.targetLearning ?? [],
                    //               linkZoom: cls.zoomLink ?? '',
                    //               namaKelas: cls.name ?? '',
                    //             ),
                    //           ),
                    //         );
                    //       }
                    //     },
                    //     child: Text(
                    //       'Lihat Kelas',
                    //       style: FontFamily().buttonText.copyWith(
                    //             color: ColorStyle().secondaryColors,
                    //           ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSessionWidget(Session session) {
    DateTime parsedJadwal = DateTime.parse(session.dateTime!);
    String formattedJadwal = DateFormat('dd MMMM yyyy').format(parsedJadwal);
    final DateFormat formatOutput = DateFormat("HH:mm");
    final String formattedStartTime =
        formatOutput.format(DateTime.parse(session.startTime!));
    final String formattedEndTime =
        formatOutput.format(DateTime.parse(session.endTime!));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._filteredSessions.map((participant) {
          final session = participant;
          int statusButtonSessions = _getPrioritySession(session);
          DateTime parsedJadwal = DateTime.parse(session.dateTime!);
          String formattedJadwal =
              DateFormat('dd MMMM yyyy').format(parsedJadwal);
          final DateFormat formatOutput = DateFormat("HH:mm");
          final String formattedStartTime =
              formatOutput.format(DateTime.parse(session.startTime!));
          final String formattedEndTime =
              formatOutput.format(DateTime.parse(session.endTime!));
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorStyle().tertiaryColors,
                    width: 2,
                  ),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (statusButtonSessions == 1)
                                  createStatusButton(
                                      "Active", ColorStyle().succesColors)
                                else if (statusButtonSessions == 2)
                                  createStatusButton(
                                      "Scheduled", ColorStyle().secondaryColors)
                                else if (statusButtonSessions == 3)
                                  createStatusButton(
                                      "Full", ColorStyle().fullbookedColors)
                                else if (statusButtonSessions == 4)
                                  createStatusButton(
                                      "Finished", ColorStyle().disableColors)
                                else if (statusButtonSessions == 5)
                                  createStatusButton(
                                      "Expired", ColorStyle().errorColors),
                                const SizedBox(height: 12),
                                Text(session.title ?? '',
                                    style: FontFamily().titleText.copyWith(
                                          color: ColorStyle().secondaryColors,
                                        )),
                                const SizedBox(height: 12),
                                Text(
                                  'Jadwal : $formattedJadwal',
                                  style: FontFamily().regularText,
                                ),
                                Text(
                                  'Jam : $formattedStartTime - $formattedEndTime',
                                  style: FontFamily().regularText,
                                ),
                                Text(
                                  //jumlah peserta
                                  'Jumlah Peserta : ${session.participant!.length}',
                                  style: FontFamily().regularText,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, top: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 150,
                            height: 38,
                            decoration: BoxDecoration(
                              color: ColorStyle().primaryColors,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                foregroundColor: ColorStyle().whiteColors,
                              ),
                              onPressed: () {
                                final zommLink = session.zoomLink ?? '';
                                _launchURL(zommLink);
                              },
                              icon: Icon(Icons.link),
                              label: Text(
                                'Join Session',
                                style: FontFamily().regularText.copyWith(
                                      color: ColorStyle().whiteColors,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
