import 'package:flutter/material.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/card/card_premium_class.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class ContohPremiumClass extends StatefulWidget {
  ContohPremiumClass({Key? key}) : super(key: key);

  @override
  State<ContohPremiumClass> createState() => _ContohPremiumClassState();
}

class _ContohPremiumClassState extends State<ContohPremiumClass> {
  bool isDropdownOpenedNameClass = false;
  bool isDropdownOpenedRincianKegiatan = false;
  bool isDropdownOpenedTarget = false;
  bool isDropdownOpenedSyarat = false;
  IconData dropdownIcon = Icons.arrow_drop_down_outlined;

  void toggleDropdown(String dropdownKey) {
    setState(() {
      if (dropdownKey == "NameClass") {
        isDropdownOpenedNameClass = !isDropdownOpenedNameClass;
      } else if (dropdownKey == "RincianKegiatan") {
        isDropdownOpenedRincianKegiatan = !isDropdownOpenedRincianKegiatan;
      } else if (dropdownKey == "Target") {
        isDropdownOpenedTarget = !isDropdownOpenedTarget;
      } else if (dropdownKey == "Syarat") {
        isDropdownOpenedSyarat = !isDropdownOpenedSyarat;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contoh Panduan Pembuatan Premium Class',
          style: FontFamily()
              .boldText
              .copyWith(color: ColorStyle().primaryColors, fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CardContohPremiumClass(
                    tittle: 'Tingkat Pendidikan',
                    desc:
                        'Tingkat pendidikan dapat kamu isi sesuai dengan level pendidikan kelas yang ingin kamu buat mulai dari SD, SMP, SMA, Kuliah dan Karier'),
                CardContohPremiumClass(
                    tittle: 'Bidang & Minat',
                    desc:
                        'Isilah bidang dan minat dengan memilih opsi yang sesuai dengan fokus dari kelas yang Anda buat atau bidang lain yang relevan dengan konten kelas yang Anda tawarkan.'),
                CardContohPremiumClassDropDown(
                  widget: Text(
                    'UI/UX Research & Design',
                    style: FontFamily().regularText.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  isDropdownOpened: isDropdownOpenedNameClass,
                  title: 'Nama Kelas',
                  desc:
                      'Nama kelas dapat disesuaikan dengan judul kelas yang ingin kamu buat',
                  subtitle: 'Contoh Nama Kelas',
                  dropdownContent: isDropdownOpenedNameClass,
                  toggleDropdown: () => toggleDropdown('NameClass'),
                ),
                CardContohPremiumClass(
                  tittle: 'Harga',
                  desc:
                      'Harga kelas dapat kamu isi sesuai dengan nilai yang Anda yakini mencerminkan nilai dari materi, pengalaman pembelajaran, serta bimbingan yang diberikan dalam kelas ini. Usahakan harga sesuai dengan kapasitas mentee yang akan kamu buat. Namun harga tersebut akan dipotong 70% sesuai dengan syarat & ketentuan yang telah berlaku. ',
                ),
                CardContohPremiumClass(
                  tittle: 'Kapasitas Kelas',
                  desc:
                      'Kapasitas mentee dapat kamu isi sesuai dengan jumlah mentee yang ingin kamu buka di kelas ini. ',
                ),
                CardContohPremiumClass(
                  tittle: 'Periode Kelas',
                  desc:
                      'Periode kelas merupakan berapa durasi kelas akan kamu buka dari awal hingga selesai',
                ),
                CardContohPremiumClass(
                  tittle: 'Jadwal Hari',
                  desc:
                      'Jadwal hari dapat kamu isi sesuai dengan hari apa saja meeting class ini akan berlangsung',
                ),
                CardContohPremiumClassDropDown(
                  widget: Text(
                    'Kelas UI/UX Research and Design adalah program intensif selama 30 hari yang memperkenalkan dan memperdalam konsep dan keterampilan dalam desain antarmuka pengguna (UI) dan pengalaman pengguna (UX). Dihadiri oleh 5 peserta, kelas ini diselenggarakan secara offline dengan pertemuan setiap Senin, Rabu, dan Jumat selama 3 jam, dari jam 10 pagi sampai jam 1 siang. Setiap minggu, peserta akan mempelajari satu chapter dari materi yang disediakan dalam bentuk modul. Mereka diberi waktu satu minggu untuk menyelesaikan materi sebelum memasuki chapter berikutnya. Evaluasi dilakukan setiap selesai chapter untuk mengukur pemahaman dan kemajuan peserta. Ini memberikan kesempatan bagi peserta untuk mendapatkan umpan balik dan bimbingan tambahan',
                    style: FontFamily().regularText.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  isDropdownOpened: isDropdownOpenedRincianKegiatan,
                  title: 'Rincian Kegiatan',
                  desc:
                      'Rincian Kegiatan merupakan deskripsi kelas ini memberikan gambaran umum tentang program pelatihan UI/UX Research and Design yang akan diselenggarakan, termasuk durasi, kapasitas peserta, jadwal, dan metodologi evaluasi.',
                  subtitle: 'Contoh Rincian Kegiatan',
                  dropdownContent: isDropdownOpenedRincianKegiatan,
                  toggleDropdown: () => toggleDropdown('RincianKegiatan'),
                ),
                CardContohPremiumClassDropDown(
                  title: 'Target Pembelajaran',
                  desc:
                      'Target pembelajarn berisi tentang topik yang akan di pelajari oleh mentee selama periode berlangsung.',
                  subtitle: 'Contoh Target Pembelajaran',
                  widget: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Memahami UX Writing danmenerapkan keahlian UI/UX Revamap dan dipublikasikan pada stakeholer',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Mampu membuat Prototype produk dengan menggunakan design sistem yang disusun',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Memahami Fundamental UI//UX',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Memahami design thinking process empathizing dan memahami kebutuhan user',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Memahami design thiking proces defining & ideation dengan kompeten untuk mencari solusi dari permasalahn yang di hadapi user',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Memahami mekanisme testing untuk diterapkan pada design produk yang dibuat dan menerima feedback dari setiap user testing',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Memahami peran UI/UX dalam pengembangan perangkat lunak',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  isDropdownOpened: isDropdownOpenedTarget,
                  dropdownContent: isDropdownOpenedTarget,
                  toggleDropdown: () => toggleDropdown('Target'),
                ),
                CardContohPremiumClassDropDown(
                  title: 'Syarat & Ketentuan',
                  desc:
                      'Ini adalah persyaratan yang harus dipatuhi oleh peserta atau apa yang harus dimiliki oleh peserta saat mendaftar kelas ini. Hal ini dilakukan untuk memastikan bahwa peserta memahami persyaratan dan ketentuan yang berlaku',
                  subtitle: 'Contoh Syarat & Ketentuan',
                  widget: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Memiliki intregritas dan kesungguhan dalam menjalankan premium class',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Mempunyai komitmen yang tinggi dalam mengikuti kelas',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Selama kelas berlangsung di harapkan mentee dan mentor oncam agar proses pembelajaran berjalan dengan kodusif',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Memiliki laptop dengan spesifikasi minimal (Prosesor intel RAM minimum 7 Gb)',
                              style: FontFamily().regularText.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  isDropdownOpened: isDropdownOpenedSyarat,
                  dropdownContent: isDropdownOpenedSyarat,
                  toggleDropdown: () => toggleDropdown('Syarat'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
