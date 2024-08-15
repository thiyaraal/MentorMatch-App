import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class InputLinkSessionAdminListScreen extends StatefulWidget {
  InputLinkSessionAdminListScreen({Key? key}) : super(key: key);

  @override
  State<InputLinkSessionAdminListScreen> createState() =>
      _InputLinkSessionAdminListScreenState();
}

class _InputLinkSessionAdminListScreenState
    extends State<InputLinkSessionAdminListScreen> {
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
                              "3 Bulan",
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
