import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class ExperienceWidget extends StatefulWidget {
  final String role;
  final String company;
  ExperienceWidget({Key? key, required this.role, required this.company})
      : super(key: key);

  @override
  State<ExperienceWidget> createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.work_outline_outlined,
              size: 16, color: ColorStyle().primaryColors),
          SizedBox(width: 8), // Sesuaikan sesuai dengan kebutuhan Anda
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Atur sesuai kebutuhan
            children: [
              Text(widget.role, style: FontFamily().boldText),
              Text(widget.company, style: FontFamily().regularText),
            ],
          )
        ],
      ),
    );
  }
}

class JadwalSessionWidget extends StatefulWidget {
  final String title1;
  final String title2;
  final IconData icon;
  const JadwalSessionWidget(
      {Key? key, required this.title1, required this.title2, required this.icon})
      : super(key: key);

  @override
  State<JadwalSessionWidget> createState() => _JadwalSessionWidgetState();
}

class _JadwalSessionWidgetState extends State<JadwalSessionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(widget.icon, size: 24, color: ColorStyle().secondaryColors),
          const SizedBox(width: 8), // Sesuaikan sesuai dengan kebutuhan Anda
          Flexible(
            // Tambahkan widget Flexible
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Atur sesuai kebutuhan
              children: [
                Text(widget.title1,
                    style: FontFamily().boldText.copyWith(
                          color: ColorStyle().secondaryColors,
                          fontSize: 14
                        )),
                Text(
                  widget.title2,
                  style: FontFamily().regularText.copyWith(
                        fontSize: 12,
                          color: ColorStyle().disableColors,
                      ),
                  softWrap:
                      true, // Memungkinkan teks untuk wrap jika terlalu panjang
                  overflow: TextOverflow.fade, // Menangani overflow teks
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
