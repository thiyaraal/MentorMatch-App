import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/admin/model/list_session_model.dart';
import 'package:my_flutter_app/admin/service/list_session_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class SessionAdminListScreen extends StatefulWidget {
  SessionAdminListScreen({Key? key}) : super(key: key);

  @override
  State<SessionAdminListScreen> createState() => _SessionAdminListScreenState();
}

class _SessionAdminListScreenState extends State<SessionAdminListScreen> {
  late Future<List<Session>> _sessionsFuture;
  late List<TextEditingController> _zoomLinkControllers = [];

  Future<void> addZoomLink(String sessionId, String zoomLink) async {
    try {
      await ListSessionService().addZoomLink(sessionId, zoomLink);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: ColorStyle().primaryColors,
          behavior: SnackBarBehavior.floating,
          content: Text('Berhasil menambahkan link'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text('Gagal menambahkan link: $e'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _sessionsFuture = _fetchSessions(); // Assign the future from _fetchSessions
  }

  Future<List<Session>> _fetchSessions() async {
    try {
      List<Session> sessions = await ListSessionService().fetchSessions();
      _zoomLinkControllers = List.generate(
        sessions.length,
        (index) => TextEditingController(),
      );
      return sessions;
    } catch (e) {
      // Handle error fetching sessions
      print('Error fetching sessions: $e');
      return []; // Return an empty list in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _sessionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Check for non-empty data
            List<Session> sessions = snapshot.data!;
            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sessions.asMap().entries.map((entry) {
                int index = entry.key;
                Session session = entry.value;
                TextEditingController controller = _zoomLinkControllers[index];
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorStyle().tertiaryColors,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    child: CachedNetworkImage(
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/blank_profile.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  imageUrl: session.mentor?.photoUrl ?? '',
                                  fit: BoxFit.cover,
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        session.title ?? '',
                                        style: FontFamily().titleText.copyWith(
                                              fontSize: 12,
                                            ),
                                      ),
                                      Text(
                                        "${DateFormat('dd MMMM yyyy').format(DateTime.parse(session.dateTime ?? ''))} (${DateFormat('HH:mm').format(DateTime.parse(session.startTime ?? ''))} - ${DateFormat('HH:mm').format(DateTime.parse(session.endTime ?? ''))})",
                                        style:
                                            FontFamily().regularText.copyWith(
                                                  fontSize: 12,
                                                ),
                                      ),
                                      Text("Mentor: ${session.mentor?.name}",
                                          style:
                                              FontFamily().regularText.copyWith(
                                                    fontSize: 12,
                                                  )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            session.zoomLink != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          session.zoomLink ?? '',
                                          style:
                                              FontFamily().regularText.copyWith(
                                                    fontSize: 12,
                                                  ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // Menyalin teks ke clipboard
                                          Clipboard.setData(ClipboardData(
                                              text: session.zoomLink ?? ''));

                                          // Tampilkan snackbar atau pesan bahwa teks telah disalin
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration:
                                                  const Duration(seconds: 2),
                                              backgroundColor:
                                                  ColorStyle().tertiaryColors,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text('Link disalin',
                                                  style: FontFamily()
                                                      .regularText
                                                      .copyWith(
                                                        fontSize: 12,
                                                      )),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.copy),
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        // child: Text(
                                        //   session.zoomLink ?? '',
                                        //   style:
                                        //       FontFamily().regularText.copyWith(
                                        //             fontSize: 12,
                                        //           ),
                                        // ),
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          child: TextField(
                                            controller: controller,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: ColorStyle()
                                                  .tertiaryColors, // Contoh warna latar belakang, sesuaikan dengan kebutuhan
                                              contentPadding: EdgeInsets.all(
                                                  8.0), // Padding dalam container
                                              hintText:
                                                  'Masukkan link zoom di sini', // Teks bantu untuk memberi tahu pengguna
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide
                                                    .none, // Menghilangkan border luar
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4), // Membulatkan sudut
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide
                                                    .none, // Gaya border saat enabled
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4), // Membulatkan sudut
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide
                                                    .none, // Gaya border saat fokus
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4), // Membulatkan sudut
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 160,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              addZoomLink(session.id ?? '',
                                                  controller.text);
                                              // refresh data and delete text field

                                              setState(() {
                                                _sessionsFuture =
                                                    ListSessionService()
                                                        .fetchSessions();
                                                controller.clear();
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  ColorStyle().primaryColors,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Text("Kirim Link"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              }).toList(),
            ));
          } else {
            return Center(child: Text('No data found'));
          }
        });
  }
}
