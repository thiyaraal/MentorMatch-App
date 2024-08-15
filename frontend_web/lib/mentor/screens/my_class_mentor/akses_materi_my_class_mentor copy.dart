import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/detail_class_mentor_all_screen.dart';
import 'package:my_flutter_app/mentor/model/my_class_mentor_model.dart';
import 'package:my_flutter_app/mentor/service/myClassCreate_Mentor_service.dart';
import 'package:my_flutter_app/mentor/service/sent_materi_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/flushsBar_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMateriMentor extends StatefulWidget {
  final String classId;
  final List<LearningMaterialMentor> learningMaterial;
  const MyMateriMentor(
      {Key? key, required this.classId, required this.learningMaterial})
      : super(key: key);

  @override
  State<MyMateriMentor> createState() => _MyMateriMentorState();
}

class _MyMateriMentorState extends State<MyMateriMentor> {
  List<String> learningMaterial = [];
  late Future<MyClassMentorMondel> _futureClassData;

  @override
  void initState() {
    super.initState();
    _futureClassData = ListClassMentor().fetchClassData();
  }

  final TextEditingController _materiPembelajaranController =
      TextEditingController();
  final TextEditingController _linkMateriPembelajaranController =
      TextEditingController();

  bool _isLoading = false;

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
  void dispose() {
    _materiPembelajaranController.dispose();
    _linkMateriPembelajaranController.dispose();

    super.dispose();
  }

  // Fungsi untuk mengirim materi pembelajaran
  Future<void> _sendMaterial() async {
    String title = _materiPembelajaranController.text;
    String link = _linkMateriPembelajaranController.text;

    if (title.isEmpty || link.isEmpty) {
      // Tampilkan pesan error jika salah satu field kosong
      showTopSnackBar(context, "Field tidak boleh kosong",
          leftBarIndicatorColor: ColorStyle().errorColors);
      return;
    }

    // Mendapatkan classId dari konteks (Misalnya, dari Navigator arguments atau state lain)
    String classId =
        widget.classId; // Asumsikan classId didapatkan dari parameter widget

    setState(() {
      _isLoading = true; // Menandai bahwa request sedang diproses
    });

    try {
      LearningMaterialService service = LearningMaterialService();
      String responseMessage =
          await service.createLearningMaterial(classId, title, link);

      // Tampilkan pesan sukses jika response message sesuai
      if (responseMessage == "Learning material created successfully") {
        // ignore: use_build_context_synchronously
        showTopSnackBar(context, responseMessage,
            leftBarIndicatorColor: ColorStyle().succesColors);
      } else {
        // Tampilkan pesan error jika response message tidak sesuai
        // ignore: use_build_context_synchronously
        showTopSnackBar(context, responseMessage,
            leftBarIndicatorColor: ColorStyle().errorColors);
      }

      // Bersihkan field setelah pengiriman berhasil
      _materiPembelajaranController.clear();
      _linkMateriPembelajaranController.clear();
    } catch (e) {
      // Tampilkan pesan error
      showTopSnackBar(context, e.toString(),
          leftBarIndicatorColor: ColorStyle().errorColors);
    } finally {
      setState(() {
        _isLoading = false; // Proses selesai, hilangkan indikator loading
      });

      // Refresh data kelas setelah pengiriman materi selesai
      setState(() {
        _futureClassData = ListClassMentor().fetchClassData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Materi Pembelajaran",
          style: FontFamily().boldText.copyWith(
                color: ColorStyle().primaryColors,
                fontSize: 16,
              ),
        ),
      ),
      body: FutureBuilder<MyClassMentorMondel>(
        future: _futureClassData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData &&
              snapshot.data!.user?.userClass != null) {
            var userClass = snapshot.data!.user!.userClass!;

            final classData = userClass.firstWhere(
              (userClass) => userClass.id == widget.classId,
              orElse: () => AllClass(),
            );

            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: _buildFormSection(),
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 350,
                      maxCrossAxisExtent: 250),
                  itemCount: classData.learningMaterial!.length,
                  itemBuilder: (context, index) {
                    return _buildGridItem(index, classData);
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Data kelas tidak ditemukan"),
            );
          }
        },
      ),
    );
  }

  Widget _buildFormSection() {
    // Kode untuk membangun bagian form
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.all(color: ColorStyle().tertiaryColors, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                "Kirim Materi Pembelajaran",
                style: FontFamily()
                    .boldText
                    .copyWith(color: ColorStyle().primaryColors, fontSize: 16),
              ),
            ),
            TittleTextField(
              title: "Materi Pembelajaran",
              color: ColorStyle().secondaryColors,
            ),
            TextFieldWidget(
              controller: _materiPembelajaranController,
              hintText: "nama topik materi pembelajaran",
            ),
            TittleTextField(
              title: "Link Materi Pembelajaran",
              color: ColorStyle().secondaryColors,
            ),
            TextFieldWidget(
              controller: _linkMateriPembelajaranController,
              hintText: "masukkan link materi pembelajaran",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field tidak boleh kosong';
                }

                const urlPattern =
                    r'^(https?:\/\/)?([a-z0-9-]+\.)+[a-z]{2,6}(\/[^\s]*)?$';
                final urlRegExp = RegExp(urlPattern);

                if (!urlRegExp.hasMatch(value)) {
                  return 'Please enter a valid URL';
                }

                return null;
              },
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: _isLoading
                  ? const CircularProgressIndicator() // Tampilkan indikator loading jika sedang loading
                  : SmallElevatedButtonTag(
                      onPressed: _isLoading
                          ? null
                          : () {
                              // Ketika tombol ditekan, atur _isLoading menjadi true
                              setState(() {
                                _isLoading = true;
                              });
                              // Lakukan aksi yang diperlukan (contoh: _sendMaterial)
                              _sendMaterial().then((_) {
                                // Ketika aksi selesai, atur _isLoading menjadi false
                                setState(() {
                                  _isLoading = false;
                                });
                              });
                            },
                      height: 40,
                      width: 118,
                      title: "Kirim",
                      style: FontFamily().buttonText.copyWith(
                            fontSize: 12,
                            color: ColorStyle().whiteColors,
                          ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(int materialIndex, AllClass classData) {
    final material = classData.learningMaterial![materialIndex];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorStyle().tertiaryColors,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: AspectRatio(
          aspectRatio: 3 / 4, // Adjust the aspect ratio as needed
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Image.asset('assets/Handoff/icon/MyClass/materi_icon.png'),
                const SizedBox(height: 8),
                Text(material.title ?? '', style: FontFamily().regularText),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ColorStyle().secondaryColors),
                  ),
                  onPressed: () {
                    final linkEvaluasi = material.link ?? '';
                    _launchURL(linkEvaluasi);
                  },
                  child: Text(
                    'Lihat Materi',
                    style: FontFamily().buttonText.copyWith(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
