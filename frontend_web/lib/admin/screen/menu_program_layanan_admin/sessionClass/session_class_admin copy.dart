import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    super.initState();
    _sessionsFuture = ListSessionService().fetchSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                        child: Image.asset(
                          fit: BoxFit.cover,
                          "assets/Handoff/Ilustrator/profile.png",
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
                              "UI/UX Research and Design",
                              style: FontFamily().titleText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                            Text(
                              "3 Bulan hahaha",
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.emoji_people_rounded,
                                  color: ColorStyle().secondaryColors,
                                ),
                                Text(": Stevenley",
                                    style: FontFamily().regularText.copyWith(
                                          fontSize: 12,
                                        )),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.person,
                                    color: ColorStyle().secondaryColors),
                                Text(": Thiyaraal",
                                    style: FontFamily().regularText.copyWith(
                                          fontSize: 12,
                                        )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'htttps/inilinkmentorigyangakankamuakses',
                          style: FontFamily().regularText.copyWith(
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
                          Clipboard.setData(const ClipboardData(
                              text: 'htttps/inilinkmentorigyangakankamuakses'));

                          // Tampilkan snackbar atau pesan bahwa teks telah disalin
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 2),
                              backgroundColor: ColorStyle().tertiaryColors,
                              behavior: SnackBarBehavior.floating,
                              content: Text('Link disalin',
                                  style: FontFamily().regularText.copyWith(
                                        fontSize: 12,
                                      )),
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
