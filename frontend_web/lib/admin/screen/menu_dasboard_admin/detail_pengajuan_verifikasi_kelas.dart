import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/admin/model/unverified_class_model.dart';
import 'package:my_flutter_app/admin/screen/dasboard_admin_screen.dart';
import 'package:my_flutter_app/admin/service/unverified_class_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class DetailPengajuanKelasScreen extends StatefulWidget {
  final Class classDetail;

  DetailPengajuanKelasScreen({Key? key, required this.classDetail})
      : super(key: key);

  @override
  State<DetailPengajuanKelasScreen> createState() =>
      _DetailPengajuanKelasScreenState();
}

class _DetailPengajuanKelasScreenState
    extends State<DetailPengajuanKelasScreen> {
  TextEditingController zoomLinkController = TextEditingController();
  TextEditingController rejectReasonController = TextEditingController();

  Future<void> verifyClass() async {
    String classId =
        widget.classDetail.id!; // Asumsi classDetail memiliki properti id
    String zoomLink = zoomLinkController.text;

    try {
      await UnverifiedClassService().verifyClass(classId, zoomLink);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Class verified successfully')));

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardAdminScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to verify class: $e')));
    }
  }

  Future<void> rejectClass() async {
    String classId = widget.classDetail.id!;
    String rejectReason = rejectReasonController.text;

    try {
      await UnverifiedClassService().rejectClass(classId, rejectReason);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Class rejected successfully')));

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardAdminScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to reject class: $e')));
    }
  }

  int calculateDaysDifference(String? start, String? end) {
    if (start == null || end == null) return 0;
    DateTime startDate = DateTime.parse(start);
    DateTime endDate = DateTime.parse(end);
    return endDate.difference(startDate).inDays;
  }

  @override
  void dispose() {
    zoomLinkController.dispose();
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
                            "Pengajuan Class Ditolak",
                            style: FontFamily().titleText.copyWith(
                                  color: ColorStyle().secondaryColors,
                                  fontSize: 24,
                                ),
                          ),
                          Text(
                            "Silahkan isi alasan pengajuan class di tolak dibawah ini agar mentor dapat mengetahui alasan pengajuan class anda di tolak.",
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
                                  "isi alasan pengajuan class di tolak disini...",
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
                          rejectClass();
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
    final classDetail = widget.classDetail;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verifikasi Premium Class',
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
                  title: 'Nama Mentor',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  // get mentor name from classDetail
                  text: classDetail.mentor?.name ?? 'Mentor Name',
                ),
                TittleTextField(
                  title: 'Tingkat Pendidikan',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: classDetail.educationLevel ?? 'Detail Kelas',
                ),
                TittleTextField(
                  title: 'Bidang dan Minat',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: classDetail.category ?? 'Category',
                ),
                TittleTextField(
                  title: 'Nama Kelas',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: classDetail.name ?? 'Nama Kelas',
                ),
                TittleTextField(
                  title: 'Harga',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: classDetail.price.toString(),
                ),
                TittleTextField(
                  title: 'Kapasitas Mentee',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: classDetail.maxParticipants.toString(),
                ),
                TittleTextField(
                  title: 'Periode Kelas',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                // hitung periode kelas dari startDate dan endDate , tamoikan dalam hari

                ContainerField(
                  text:
                      "${calculateDaysDifference(classDetail.startDate, classDetail.endDate).toString()} hari",
                ),
                TittleTextField(
                  title: 'Tanggal Mulai',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: classDetail.startDate == null
                      ? 'Start Date'
                      : DateFormat('dd MMMM yyyy')
                          .format(DateTime.parse(classDetail.startDate!)),
                ),
                TittleTextField(
                  title: 'Tanggal Selesai',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: classDetail.endDate == null
                      ? 'End Date'
                      : DateFormat('dd MMMM yyyy')
                          .format(DateTime.parse(classDetail.endDate!)),
                ),
                TittleTextField(
                  title: 'Location',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: classDetail.location ?? 'Location',
                ),
                TittleTextField(
                  title: 'Alamat',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),

                if (classDetail.location == 'Online')
                  ContainerField(
                    text: 'Zoom',
                  )
                else
                  ContainerField(
                    text: classDetail.address ?? 'Address',
                  ),
                TittleTextField(
                  title: 'Rincian Kegiatan Kelas',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                ContainerField(
                  text: classDetail.description ?? 'Description of the class',
                ),
                TittleTextField(
                  title: 'Target Pembelajaran',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),

// Menampilkan setiap target pembelajaran dalam ContainerField dengan bullet
                Column(
                  children: classDetail.targetLearning != null
                      ? classDetail.targetLearning!.map((item) {
                          return ContainerField(text: "• $item");
                        }).toList()
                      : [ContainerField(text: '• Target Learning')],
                ),
                TittleTextField(
                  title: 'Syarat dan Ketentuan',
                  color: ColorStyle().secondaryColors,
                  textAlign: TextAlign.start,
                ),
                Column(
                  children: classDetail.terms != null
                      ? classDetail.terms!.map((item) {
                          return ContainerField(text: "$item");
                        }).toList()
                      : [ContainerField(text: 'Terms and Conditions')],
                ),

                if (classDetail.location == 'Online')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(
                        title: 'Link Zoom',
                        color: ColorStyle().secondaryColors,
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        width: 1300,
                        padding: EdgeInsets.all(12),
                        child: TextField(
                          controller: zoomLinkController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorStyle()
                                .tertiaryColors, // Contoh warna latar belakang, sesuaikan dengan kebutuhan
                            contentPadding:
                                EdgeInsets.all(8.0), // Padding dalam container
                            hintText:
                                'Masukkan link zoom di sini', // Teks bantu untuk memberi tahu pengguna
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide.none, // Menghilangkan border luar
                              borderRadius:
                                  BorderRadius.circular(4), // Membulatkan sudut
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide.none, // Gaya border saat enabled
                              borderRadius:
                                  BorderRadius.circular(4), // Membulatkan sudut
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide.none, // Gaya border saat fokus
                              borderRadius:
                                  BorderRadius.circular(4), // Membulatkan sudut
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: 20),
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
                        verifyClass(); // Memanggil fungsi verifikasi kelas
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
  ContainerField({
    super.key,
    required this.text,
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
              style: FontFamily().regularText.copyWith(
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
