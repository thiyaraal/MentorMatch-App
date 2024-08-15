import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/mentee/model/mentor_model.dart';
import 'package:my_flutter_app/mentee/model/my_class_model.dart';
import 'package:my_flutter_app/mentee/model/session_model.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/detail_class_mentor_all_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/detail_mentor_all_screen.dart';
import 'package:my_flutter_app/mentee/screen/session/detail_mentor_session_screen.dart';
import 'package:my_flutter_app/mentee/screen/sidebar/my_class/detail_my_class_mentee_screen.dart';
import 'package:my_flutter_app/mentee/service/my_class_service.dart';
import 'package:my_flutter_app/mentee/service/session_mentor_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/card_mentor.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/mentor_service.dart';

class SearchPageMenteeWeb extends StatefulWidget {
  @override
  _SearchPageMenteeWebState createState() => _SearchPageMenteeWebState();
}

class _SearchPageMenteeWebState extends State<SearchPageMenteeWeb> {
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();
  bool isSearching = false;

////classs//
  List<ClassMyClass> _classes = [];
  List<ClassMyClass> _filteredClasses = [];

///// session ///
  List<ParticipantMyClass> _sessions = [];
  List<ParticipantMyClass> _filteredSessions = [];

  /// mentor session ///
  List<MentorSession> _mentorsSessions = [];
  List<MentorSession> _filteredMentors = [];

  // Premium Mentors
  List<MentorClassAll> _mentorsPremium = [];
  List<MentorClassAll> _filteredMentorsPremium = [];

//// future class ////
  Future<void> _fetchClasses() async {
    try {
      final List<TransactionMyClass> transactions =
          await BookingService().fetchUserTransactions();

      // Buat list class dari transaksi yang diperoleh
      List<ClassMyClass> classes = transactions
          .map((transaction) => transaction.transactionClass!)
          .toList();

      setState(() {
        _classes = classes;
        _filteredClasses = _classes;
      });
    } catch (e) {
      print(e); // Tangani kesalahan sesuai kebutuhan aplikasi Anda
    }
  }

  ///future session ////
  Future<void> _fetchSessions() async {
    try {
      final List<ParticipantMyClass> sessionsMentor =
          await BookingService().fetchUserSessions();

      setState(() {
        _sessions = sessionsMentor;
        _filteredSessions = _sessions;
      });
    } catch (e) {
      print(e);
    }
  }

  /// future mentorsession ///
  Future<void> _fetchMentorSessions() async {
    try {
      final List<MentorSession> mentors =
          await SessionServices().fetchAvailableMentors();

      // Filter the mentors to only include those who have at least one active session
      final List<MentorSession> activeMentors = mentors.where((mentor) {
        return mentor.session?.any((session) => session.isActive == true) ??
            false;
      }).toList();

      setState(() {
        _mentorsSessions = activeMentors;
        _filteredMentors = activeMentors;
      });
    } catch (e) {
      print(e);
    }
  }

  // Fetch premium mentors
  Future<void> _fetchPremiumMentors() async {
    try {
      final MentorClassModel mentors =
          await MentorService().fetchPremiumMentors();

      // Filter the mentors to only include those who have at least one available class
      final availableMentors = mentors.mentors!.where((mentor) =>
          mentor.mentorClass!.any((mentorClass) =>
              mentorClass.isAvailable == true &&
              mentorClass.isActive == false));

      setState(() {
        _mentorsPremium = availableMentors.toList();
        _filteredMentorsPremium = _mentorsPremium;
      });
      print('Fetched Premium Mentors: $_mentorsPremium'); // Debugging statement
    } catch (e) {
      print('Error fetching premium mentors: $e');
    }
  }

  ///// void filterclass ////
  void _filterClasses(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      //classes
      _filteredClasses = _classes
          .where((cls) =>
              cls.name!.toLowerCase().contains(query.toLowerCase()) ||
              cls.description!.toLowerCase().contains(query.toLowerCase()) ||
              cls.mentor!.name!.toLowerCase().contains(query.toLowerCase()) ||
              cls.durationInDays.toString().contains(query.toLowerCase()))
          .toList();
      // session
      _filteredSessions = _sessions
          .where((session) =>
              session.session!.title!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              session.session!.description!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
      //// mentor session
      _filteredMentors = _mentorsSessions.where((mentor) {
        final nameLower = mentor.name?.toLowerCase() ?? '';
        final skillsLower =
            mentor.skills?.map((skill) => skill.toLowerCase()).join(', ') ?? '';
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower) ||
            skillsLower.contains(queryLower);
      }).toList();
      // Filter premium mentors
      _filteredMentorsPremium = _mentorsPremium.where((mentor) {
        final nameLower = mentor.name?.toLowerCase() ?? '';
        final skillsLower =
            mentor.skills?.map((skill) => skill.toLowerCase()).join(', ') ?? '';
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower) ||
            skillsLower.contains(queryLower);
      }).toList();

      print(
          'Filtered Premium Mentors: $_filteredMentorsPremium'); // Debugging statement
    });
  }

  ///// future user data ////
  Future<List<dynamic>>?
      _userData; // Menggunakan List<dynamic> untuk menggabungkan kelas dan sesi
  int getClassStatusPriority(TransactionMyClass transaction) {
    // Gunakan logika yang sama untuk menentukan status
    DateTime now = DateTime.now();
    DateTime startDate =
        DateTime.parse(transaction.transactionClass?.startDate ?? '');
    DateTime endDate =
        DateTime.parse(transaction.transactionClass?.endDate ?? '');
    bool isClassActive = now.isAfter(startDate) && now.isBefore(endDate);
    bool isClassScheduled =
        now.isBefore(startDate) && transaction.paymentStatus == "Approved";
    bool isClassFinished = now.isAfter(endDate);

    if (isClassActive) {
      return 1;
    } else if (isClassScheduled) {
      return 2;
    } else if (transaction.paymentStatus == "Pending") {
      return 3;
    } else if (isClassFinished) {
      return 4;
    } else if (transaction.paymentStatus == "Expired") {
      return 5;
    }

    return 6; // Untuk status lain atau tidak diketahui
  }

  @override
  void initState() {
    super.initState();
    _fetchClasses();
    _fetchSessions();
    _fetchMentorSessions();
    _fetchPremiumMentors();
    _userData = _fetchUserData();
  }

  // Fetch user data
  Future<List<dynamic>> _fetchUserData() async {
    List<TransactionMyClass> transactions =
        await BookingService().fetchUserTransactions();
    List<ParticipantMyClass> sessions =
        await BookingService().fetchUserSessions();

    List<dynamic> combinedList = [];
    combinedList.addAll(transactions);
    combinedList.addAll(sessions);

    return combinedList;
  }

  Widget createStatusButton(String title, Color color) {
    return Align(
      alignment: Alignment.centerRight,
      child: SmallElevatedButtonTag(
        color: color,
        onPressed: () {}, // Define the action
        height: 28,
        width: 124,
        title: title,
        style: FontFamily().buttonText,
      ),
    );
  }

  /// link zoom akses///
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
        title: Text('Search Class'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                      hintText: 'search by mentor name and class name',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  if (_filteredClasses.isNotEmpty)
                    isSearching
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  'Premium Class',
                                  style: FontFamily().boldText.copyWith(
                                      fontSize: 16,
                                      color: ColorStyle().secondaryColors),
                                ),
                              ),
                              ..._filteredClasses.map((clasdata) => Padding(
                                    padding: const EdgeInsets.all(12.0),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipOval(
                                                  child: CachedNetworkImage(
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    imageUrl: clasdata
                                                            .mentor!.photoUrl ??
                                                        '',
                                                    fit: BoxFit.cover,
                                                    width: 98,
                                                    height: 98,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        clasdata.name ?? '',
                                                        style: FontFamily()
                                                            .boldText
                                                            .copyWith(
                                                                fontSize: 14,
                                                                color: ColorStyle()
                                                                    .primaryColors),
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      Text(
                                                          'Mentor : ${clasdata.mentor!.name}',
                                                          style: FontFamily()
                                                              .regularText),
                                                      Text(
                                                          'Durasi : ${clasdata.durationInDays} Hari',
                                                          style: FontFamily()
                                                              .regularText),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailMyClassMenteeScreen(
                                                        learningMaterial: clasdata
                                                                .learningMaterial ??
                                                            [],
                                                        endDate: DateTime.parse(
                                                            clasdata.endDate ??
                                                                ''),
                                                        startDate: DateTime
                                                            .parse(clasdata
                                                                    .startDate ??
                                                                ''),
                                                        targetLearning: clasdata
                                                                .targetLearning ??
                                                            [],
                                                        maxParticipants: clasdata
                                                                .maxParticipants ??
                                                            0,
                                                        schedule:
                                                            clasdata.schedule ??
                                                                '',
                                                        mentorId:
                                                            clasdata.mentorId ??
                                                                '',
                                                        mentorPhoto: clasdata
                                                                .mentor!
                                                                .photoUrl ??
                                                            '',
                                                        descriptionKelas:
                                                            clasdata.description
                                                                .toString(),
                                                        terms: clasdata.terms ??
                                                            [],
                                                        evaluasi: clasdata
                                                                .evaluations ??
                                                            [],
                                                        linkEvaluasi:
                                                            clasdata.zoomLink ??
                                                                '',
                                                        mentorName: clasdata
                                                                .mentor!.name ??
                                                            '',
                                                        linkZoom:
                                                            clasdata.zoomLink ??
                                                                '',
                                                        namaKelas:
                                                            clasdata.name ?? '',
                                                        periode: clasdata
                                                                .durationInDays ??
                                                            0,
                                                        classData: clasdata,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'Lihat Kelas',
                                                  style: FontFamily()
                                                      .boldText
                                                      .copyWith(
                                                          color: ColorStyle()
                                                              .secondaryColors,
                                                          fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        : Container(),
                  if (_filteredSessions.isNotEmpty)
                    isSearching
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  'Session',
                                  style: FontFamily().boldText.copyWith(
                                      fontSize: 16,
                                      color: ColorStyle().secondaryColors),
                                ),
                              ),
                              ..._filteredSessions.map((participant) {
                                final session = participant.session!;
                                // int statusButton = _getPriority(session);

                                DateTime parsedJadwal =
                                    DateTime.parse(session.dateTime!);
                                String formattedJadwal =
                                    DateFormat('dd MMMM yyyy')
                                        .format(parsedJadwal);

                                final DateFormat formatOutput =
                                    DateFormat("HH:mm");
                                final String formattedStartTime = formatOutput
                                    .format(DateTime.parse(session.startTime!));
                                final String formattedEndTime = formatOutput
                                    .format(DateTime.parse(session.endTime!));
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipOval(
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                  imageUrl: participant.session!
                                                          .mentor!.photoUrl ??
                                                      '',
                                                  fit: BoxFit.cover,
                                                  width: 98,
                                                  height: 98,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      session.title ?? '',
                                                      style: FontFamily()
                                                          .boldText
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: ColorStyle()
                                                                  .primaryColors),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Text(
                                                      'Mentor : ${session.mentor!.name}',
                                                      style: FontFamily()
                                                          .regularText,
                                                    ),
                                                    Text(
                                                      'Jadwal : ${formattedJadwal}',
                                                      style: FontFamily()
                                                          .regularText,
                                                    ),
                                                    Text(
                                                      'Jam : ${formattedStartTime} - ${formattedEndTime}',
                                                      style: FontFamily()
                                                          .regularText,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0, top: 8.0),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                width: 150,
                                                height: 38,
                                                decoration: BoxDecoration(
                                                  color: ColorStyle()
                                                      .primaryColors,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: TextButton.icon(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        ColorStyle()
                                                            .whiteColors,
                                                  ),
                                                  onPressed: () {
                                                    final zommLink =
                                                        session.zoomLink ?? '';
                                                    _launchURL(zommLink);
                                                  },
                                                  icon: Icon(Icons.link),
                                                  label: Text(
                                                    'Join Session',
                                                    style: FontFamily()
                                                        .regularText
                                                        .copyWith(
                                                          color: ColorStyle()
                                                              .whiteColors,
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
                                );
                              }),
                            ],
                          )
                        : Container(),
                  // Daftar mentor (jika ada)
                  if (_filteredMentors.isNotEmpty)
                    isSearching
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  'Mentor Sessions',
                                  style: FontFamily().boldText.copyWith(
                                      fontSize: 16,
                                      color: ColorStyle().secondaryColors),
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  mainAxisExtent: 350,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: _filteredMentors.length,
                                itemBuilder: (context, index) {
                                  final mentor = _filteredMentors[index];

                                  // Mengambil semua sesi aktif dari mentor
                                  final activeSessions = mentor.session
                                          ?.where((session) =>
                                              session.isActive == true)
                                          .toList() ??
                                      [];

                                  // Mendapatkan pengalaman kerja terkini mentor
                                  final currentExperience =
                                      mentor.experiences?.firstWhere(
                                    (experience) =>
                                        experience.isCurrentJob ?? false,
                                    orElse: () => Experience(),
                                  );

                                  // Mendapatkan status ketersediaan sesi
                                  final isSessionFull =
                                      activeSessions.isNotEmpty &&
                                          activeSessions.any((session) =>
                                              session.participant?.length ==
                                              session.maxParticipants);

                                  // Mendapatkan jumlah peserta sesi
                                  final numberOfParticipants =
                                      activeSessions.isNotEmpty
                                          ? activeSessions
                                                  .first.participant?.length ??
                                              0
                                          : 0;

                                  // Mendapatkan warna tombol sesuai dengan status ketersediaan sesi
                                  final Color buttonColor = isSessionFull
                                      ? ColorStyle().disableColors
                                      : ColorStyle().primaryColors;

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CardItemMentor(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailMentorSessionScreen(
                                              session: mentor.session,
                                              availableSlots: mentor
                                                      .session!.isEmpty
                                                  ? 0
                                                  : mentor.session!.first
                                                          .maxParticipants! -
                                                      (mentor
                                                              .session!
                                                              .first
                                                              .participant
                                                              ?.length ??
                                                          0),
                                              detailmentor: mentor,
                                              totalParticipants:
                                                  numberOfParticipants,
                                              mentorReviews:
                                                  mentor.mentorReviews ?? [],
                                            ),
                                          ),
                                        );
                                      },
                                      title: isSessionFull
                                          ? "Full Booked"
                                          : "Available",
                                      color: buttonColor,
                                      onPressesd: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailMentorSessionScreen(
                                              session: mentor.session,
                                              availableSlots: mentor
                                                      .session!.isEmpty
                                                  ? 0
                                                  : mentor.session!.first
                                                          .maxParticipants! -
                                                      (mentor
                                                              .session!
                                                              .first
                                                              .participant
                                                              ?.length ??
                                                          0),
                                              detailmentor: mentor,
                                              totalParticipants:
                                                  numberOfParticipants,
                                              mentorReviews:
                                                  mentor.mentorReviews ?? [],
                                            ),
                                          ),
                                        );
                                      },
                                      imagePath: mentor.photoUrl ??
                                          'assets/Handoff/ilustrator/profile.png',
                                      name: mentor.name ?? 'No Name',
                                      job: currentExperience?.jobTitle ?? '',
                                      company: currentExperience?.company ??
                                          'Placeholder Company',
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : Container(),
                  // Daftar mentor premium (jika ada)
                  if (_filteredMentorsPremium.isNotEmpty)
                    isSearching
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  'Premium Mentors',
                                  style: FontFamily().boldText.copyWith(
                                      fontSize: 16,
                                      color: ColorStyle().secondaryColors),
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  mainAxisExtent: 350,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: _filteredMentorsPremium.length,
                                itemBuilder: (context, index) {
                                  final mentor = _filteredMentorsPremium[index];
                                  ExperienceClassAll? currentJob =
                                      mentor.experiences?.firstWhere(
                                    (exp) => exp.isCurrentJob ?? false,
                                    orElse: () => ExperienceClassAll(),
                                  );
                                  // Fungsi untuk mendapatkan slot yang tersedia
                                  int getAvailableSlotCount(ClassAll kelas) {
                                    int approvedCount = kelas.transactions
                                            ?.where((t) =>
                                                t.paymentStatus == "Approved")
                                            .length ??
                                        0;

                                    int pendingCount = kelas.transactions
                                            ?.where((t) =>
                                                t.paymentStatus == "Pending")
                                            .length ??
                                        0;

                                    int totalApprovedAndPendingCount =
                                        approvedCount + pendingCount;

                                    // Jumlah slot yang tersedia adalah maksimum partisipan dikurangi dengan total transaksi yang telah disetujui dan sedang diproses
                                    int availableSlots =
                                        (kelas.maxParticipants ?? 0) -
                                            totalApprovedAndPendingCount;
                                    // Pastikan slot yang tersedia tidak negatif
                                    return availableSlots > 0
                                        ? availableSlots
                                        : 0;
                                  }

// Fungsi untuk menentukan apakah semua kelas dalam daftar mentor dianggap penuh
                                  bool allClassesFull =
                                      mentor.mentorClass!.every((classMentor) {
                                    int availableSlotCount =
                                        getAvailableSlotCount(classMentor);
                                    return availableSlotCount <= 0;
                                  });

                                  String company = currentJob?.company ??
                                      'Placeholder Company';
                                  String jobTitle =
                                      currentJob?.jobTitle ?? 'Placeholder Job';

                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CardItemMentor(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailMentorAllScreen(
                                                experiences:
                                                    mentor.experiences ?? [],
                                                email: mentor.email ?? '',
                                                classes:
                                                    mentor.mentorClass ?? [],
                                                about: mentor.about ?? '',
                                                name: mentor.name ?? 'No Name',
                                                photoUrl: mentor.photoUrl ?? '',
                                                skills: mentor.skills ?? [],
                                                classid: mentor.id.toString(),
                                                company: company,
                                                job: jobTitle,
                                                linkedin: mentor.linkedin ?? '',
                                                mentor: mentor,
                                                location: mentor.location ?? '',
                                                mentorReviews:
                                                    mentor.mentorReviews ?? [],
                                              ),
                                            ),
                                          );
                                        },
                                        onPressesd: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailMentorAllScreen(
                                                experiences:
                                                    mentor.experiences ?? [],
                                                email: mentor.email ?? '',
                                                classes:
                                                    mentor.mentorClass ?? [],
                                                about: mentor.about ?? '',
                                                name: mentor.name ?? 'No Name',
                                                photoUrl: mentor.photoUrl ?? '',
                                                skills: mentor.skills ?? [],
                                                classid: mentor.id.toString(),
                                                company: company,
                                                job: jobTitle,
                                                linkedin: mentor.linkedin ?? '',
                                                mentor: mentor,
                                                location: mentor.location ?? '',
                                                mentorReviews:
                                                    mentor.mentorReviews ?? [],
                                              ),
                                            ),
                                          );
                                        },
                                        imagePath: mentor.photoUrl.toString(),
                                        name: mentor.name ?? 'No Name',
                                        job: jobTitle,
                                        company: company,
                                      ));
                                },
                              ),
                            ],
                          )
                        : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
