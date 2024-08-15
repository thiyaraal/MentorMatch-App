import 'package:flutter/material.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
class NotificationAdminScreen extends StatefulWidget {
  NotificationAdminScreen({Key? key}) : super(key: key);

  @override
  State<NotificationAdminScreen> createState() =>
      _NotificationAdminScreenState();
}

class _NotificationAdminScreenState extends State<NotificationAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: FontFamily().titleText.copyWith(
                color: ColorStyle().primaryColors,
                fontSize: 24,
              ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notification_add,
                        size: 36,
                        color: ColorStyle().primaryColors,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pengingat Aktivasi Akun',
                                style: FontFamily().titleText.copyWith(
                                    fontSize: 16,
                                    color: ColorStyle().secondaryColors),
                              ),
                              Text(
                                "Kami ingin memberi tahu Anda bahwa akun sosial media Anda telah lama tidak digunakan  Kami rindu melihat Anda aktif dan berbagi momen-momen menarik dengan komunitas kamu.",
                                style: FontFamily().regularText.copyWith(
                                      fontSize: 12,
                                    ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorStyle().tertiaryColors,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notification_add,
                        size: 36,
                        color: ColorStyle().primaryColors,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pengingat Aktivasi Akun',
                                style: FontFamily().titleText.copyWith(
                                    fontSize: 16,
                                    color: ColorStyle().secondaryColors),
                              ),
                              Text(
                                "Kami senang memberi tahu bahwa pembayaran Anda telah berhasil diproses dengan sukses. Terima kasih atas kepercayaan Anda kepada MentorMatch.",
                                style: FontFamily().regularText.copyWith(
                                      fontSize: 12,
                                    ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
