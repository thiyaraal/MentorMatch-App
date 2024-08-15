import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/model/unverified_mentor_model.dart';
import 'package:my_flutter_app/admin/screen/dasboard_admin_screen.dart';
import 'package:my_flutter_app/admin/service/unverified_mentor_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifikasiMentorScreen extends StatefulWidget {
  final Mentor mentorDetail;
  VerifikasiMentorScreen({Key? key, required this.mentorDetail})
      : super(key: key);

  @override
  State<VerifikasiMentorScreen> createState() => _VerifikasiMentorScreenState();
}

class _VerifikasiMentorScreenState extends State<VerifikasiMentorScreen> {
  TextEditingController rejectReasonController = TextEditingController();

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  Future<void> verifyMentor() async {
    String mentorId =
        widget.mentorDetail.id!; // Asumsi mentorDetail memiliki properti id

    try {
      await UnverifiedMentorService().verifyMentor(mentorId);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mentor verified successfully')));

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardAdminScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to verify mentor: $e')));
    }
  }

  Future<void> rejectMentor() async {
    String mentorId = widget.mentorDetail.id!;
    String rejectReason = rejectReasonController.text;

    try {
      await UnverifiedMentorService().rejectMentor(mentorId, rejectReason);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mentor rejected successfully')));

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardAdminScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to reject mentor: $e')));
    }
  }

  @override
  void dispose() {
    rejectReasonController.dispose();
    super.dispose();
  }

  void _showRejectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 160, minHeight: 500),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          Text(
                            "Pengajuan Mentor Ditolak",
                            style: FontFamily().titleText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 24,
                                ),
                          ),
                          Text(
                            "Silahkan isi alasan pengajuan mentor di tolak dibawah ini agar mentor dapat mengetahui alasan  penolakan.",
                            style: FontFamily().regularText.copyWith(
                                  color: ColorStyle().disableColors,
                                  fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorStyle().disableColors, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                            controller: rejectReasonController,
                            maxLines:
                                5, // Atur jumlah baris untuk membuatnya "besar"
                            decoration: InputDecoration(
                              hintText:
                                  "isi alasan pengajuan mentor ditolak disini...",
                              hintStyle: FontFamily().regularText.copyWith(
                                    color: ColorStyle().disableColors,
                                    fontSize: 12,
                                  ),

                              border: InputBorder
                                  .none, // Menghilangkan border bawaan TextField
                            ),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RegularElevatedButtonWidget(
                        // /nanti ganti ukurannya ikutin di figma, gantinya di widget nya lgsg kalo aku yang ganti
                        ///nanti jadi error pas di merge
                        text: "Kirim",
                        onPressed: () {
                          rejectMentor();
                          MaterialPageRoute(
                              builder: (context) => DashboardAdminScreen());
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Mentor mentorDetail = widget.mentorDetail;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verifikasi Mentor',
          style: FontFamily().titleText.copyWith(
                color: ColorStyle().primaryColors,
                fontSize: 24,
              ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TittleTextField(
                  title: 'Nama',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: mentorDetail.name ?? '',
                ),
                TittleTextField(
                  title: 'Gender',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: mentorDetail.gender ?? '',
                ),
                TittleTextField(
                  title: 'Job / Title',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: mentorDetail.experiences
                          ?.firstWhere(
                              (element) => element.isCurrentJob == true,
                              orElse: () => Experience())
                          .jobTitle ??
                      '',
                ),
                TittleTextField(
                  title: 'Company',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: mentorDetail.experiences
                          ?.firstWhere(
                              (element) => element.isCurrentJob == true,
                              orElse: () => Experience())
                          .company ??
                      '',
                ),
                TittleTextField(
                  title: 'Rekening Bank',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                TittleTextField(
                  title: 'Bank',
                  color: ColorStyle().primaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: "BCA",
                ),
                TittleTextField(
                  title: 'Nomor Rekening',
                  color: ColorStyle().primaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: mentorDetail.accountNumber ?? '',
                ),
                TittleTextField(
                  title: 'Nama Rekening',
                  color: ColorStyle().primaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: mentorDetail.accountName ?? '',
                ),
                TittleTextField(
                  title: 'Skill',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: mentorDetail.skills?.join(', ') ?? '',
                ),
                TittleTextField(
                  title: 'Linkedln',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                InkWell(
                  onTap: () {
                    _launchURL(mentorDetail.linkedin ?? "");
                  },
                  child: ContainerField(
                    text: mentorDetail.linkedin ?? "",
                    isLink: true, // Tandai sebagai link untuk gaya khusus
                  ),
                ),
                TittleTextField(
                  title: 'Portofolio & CV',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                // ContainerField(
                //   text: mentorDetail.portofolio ?? "-",
                // ),
                InkWell(
                  onTap: () {
                    _launchURL(mentorDetail.portofolio ?? "");
                  },
                  child: ContainerField(
                    text: mentorDetail.portofolio ?? "",
                    isLink: true,
                  ),
                ),
                TittleTextField(
                  title: 'About',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: mentorDetail.about ?? "",
                ),
                TittleTextField(
                  title: 'Experience',
                  color: ColorStyle().primaryColors,
                  textAlign: TextAlign.start,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // where experience is not current job
                      ...?mentorDetail.experiences
                          ?.where((element) => element.isCurrentJob == false)
                          .map((e) => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ContainerField(
                                    text:
                                        '${e.jobTitle ?? ''} at ${e.company ?? ''}',
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ))
                          .toList(),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RegularOutlineButtonWidget(
                      text: "Tolak",
                      onPressed: () =>
                          _showRejectDialog(context), // Memanggil fungsi reject
                    ),
                    RegularElevatedButtonWidget(
                      text: "Terima",
                      onPressed: () {
                        verifyMentor(); // Memanggil fungsi verifikasi kelas
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContainerField extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final bool isLink;

  ContainerField({
    super.key,
    required this.text,
    this.textStyle,
    this.isLink = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          Container(
            width: 1300,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: ColorStyle().tertiaryColors,
            ),
            child: Text(
              text,
              style: isLink
                  ? FontFamily().regularText.copyWith(
                        fontSize: 16,
                        color: ColorStyle().disableColors,
                        decoration: TextDecoration.underline,
                      )
                  : FontFamily().regularText.copyWith(
                        fontSize: 16,
                        color: ColorStyle().disableColors,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
